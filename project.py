import web

urls = (
    '/', 'index',
    '/smartphones', 'smartphones',
    '/smartphone/(.*)/(.*)', 'smartphone',
    '/add_smartphone', 'add_smartphone',
    '/about', 'about',
    '/news', 'news',
    '/populars', 'populars',
    '/reviews', 'reviews',
    '/review/(.*)', 'review',
    '/brand/(.*)', 'brand',
    '/add_brand', 'add_brand',
    '/search', 'search'
)

""" DB """
db = web.database(dbn='mysql', user='root', pw='', host="127.0.0.1", port=3306, db='smartphones')

""" GLOBALS """
myglobals = {
   'brands' : list(db.query("SELECT * FROM brands ORDER BY brand")),
   'menu' : [
        ("/", "home"),
        ("/smartphones", "smartphones"),
        ("/news", "news"),
        ("/populars", "populars"),
        ("/reviews", "reviews"),
        ("/about", "about")
    ]
}

""" RENDER """
render = web.template.render('templates/', base='base', globals=myglobals)

""" UTILS """
def required(input_str):
   input_str = clean_str(input_str)
   return input_str != ""

def clean_str(input_str):
   result = input_str.strip()
   words = result.split()
   words = [ w.capitalize() for w in words ]
   result = " ".join(words)
   return(result)

def is_float(input_str):
  try:
    result = float(input_str)
    return True
  except ValueError:
    return False

def get_slices(page, pagesize):
    return (pagesize * (page - 1)), (pagesize * page)


class index:
    def GET(self):
        smartphones_data = list(db.query("SELECT * FROM smartphones AS s, brands AS b WHERE b.id = s.id ORDER BY released DESC LIMIT 5"))
        reviews_data = list(db.select("reviews"))
        return render.index(smartphones_data, reviews_data)

class search:
    def GET(self):
        inp = web.input()
        search = inp.get("search", None)
        if search == None:
            raise web.seeother('/')
        results = db.query("SELECT * FROM smartphones AS s,brands AS b WHERE s.bid=b.id AND s.model LIKE $s",vars={'s':"%"+search+"%"})
        return render.search(results);

class smartphones:
    def GET(self):
        inp = web.input()

        """Filtering"""
        sfilter = inp.get("smartphones_by_brand", None)
        if sfilter == None or sfilter == "all":
            smartphones_data = list(db.query("SELECT s.model, s.display, s.power, s.battery, s.camera, s.id, b.brand, s.imagemini FROM smartphones AS s, brands AS b WHERE b.id = s.bid ORDER BY released DESC"))
        else:
            smartphones_data = list(db.query("SELECT s.model, s.display, s.power, s.battery, s.camera, s.id, b.brand, s.imagemini FROM smartphones AS s, brands AS b WHERE b.id = s.bid AND b.id = $sfilter ORDER BY released DESC", vars=locals()))
        brands = db.select("brands");

        """Pagination"""
        page = int(inp.page) if hasattr(inp, 'page') else 1
        pagesize = 4
        totalpages = len(smartphones_data)/pagesize+1
        start, end = get_slices(page, pagesize)
        return render.smartphones(smartphones_data[start:end], brands, page, totalpages)

class smartphone:
    def GET(self, sname, sid):
        sid = int(sid)
        s_item = db.query("SELECT * FROM smartphones AS s, brands AS b WHERE s.id = $sid AND b.id = s.bid", vars=locals())
        if s_item:
            item_images = list(db.select("images", where="sid=$sid", vars=locals()))
            print item_images
            return render.smartphone(s_item[0], item_images)
        else: raise web.seeother('/')

class add_smartphone:
    brands = list(db.select("brands"))
    brands = [ (b.id, b.brand) for b in brands ]
    check_number = web.form.Validator('Enter a number', is_float)
    def check_brand_models(smartphone):
        bid = smartphone.bid
        model = clean_str(smartphone.model)
        brand_models = db.query("SELECT s.model FROM smartphones AS s WHERE s.bid = $bid", vars=locals())
        brand_models = [ b.model for b in brand_models ]
        return model not in brand_models

    form_addsmartphone = web.form.Form(
        web.form.Dropdown('bid', brands, description="Brand"),
        web.form.Textbox('model', web.form.Validator('Enter a model!', required), description="Model"),
        web.form.Textbox('released', web.form.Validator('Enter a released date!', required), description="Released"),
        web.form.Textbox('dimensions', web.form.Validator('Enter dimensions!', required), description="Dimensions"),
        web.form.Textbox('weight', web.form.Validator('Enter a weight!', required), check_number, description="Weight"),
        web.form.Textarea('display', web.form.Validator('Enter display!', required), description="Display"),
        web.form.Textarea('power', web.form.Validator('Enter power!', required), description="Power"),
        web.form.Textarea('camera', web.form.Validator('Enter camera!', required), description="Camera"),
        web.form.Textarea('sensors', web.form.Validator('Enter sensors!', required), description="Sensors"),
        web.form.Textbox('battery', web.form.Validator('Enter battery!', required), check_number, description="Battery"),
        web.form.Textbox('colors', web.form.Validator('Enter colors!', required), description="Colors"),
        web.form.Textarea('content', web.form.Validator('Enter a content!', required), description="Content"),
        web.form.Checkbox('popular', description="Popular", value="0"),
        web.form.File('imagemini', description="Image mini"),
        web.form.File('featured', description="Featured Image"),
        validators = [ web.form.Validator("The smartphone exists", check_brand_models) ]
    )

    def GET(self):
        return render.add_smartphone(self.form_addsmartphone.render())

    def POST(self):
        form = self.form_addsmartphone()
        if not form.validates():
            return render.add_smartphone(form.render())
        else:
           imgupload = web.input(imagemini={})
           filedir = 'static/img'
           if 'imagemini' in imgupload:
              filepath=imgupload.imagemini.filename.replace('\\','/')
              filename=filepath.split('/')[-1]
              fout = open(filedir +'/'+ filename,'w')
              fout.write(imgupload.imagemini.file.read())
              fout.close()
           form.value.imagemini = "/static/img/"+filename
           new_bid = db.insert('smartphones', **form.value)
           raise web.seeother('/smartphone/%s/%d' % (form.d.model.replace(" ", "-"), new_bid))

class add_brand:
    def check_brand(brand):
        brands = db.select("brands")
        brands = [ b.brand for b in brands]
        brand = clean_str(brand)
        return not brand in brands

    form_addbrand = web.form.Form(
        web.form.Textbox('brand',
             web.form.Validator('Enter a brand!', required),
             web.form.Validator('Already in db!', check_brand),
             size=15,
             description= "Brand : "
        ),
        web.form.Button('Add', class_="btn-submit"),
    )

    def GET(self):
        return render.add_brand(self.form_addbrand.render())

    def POST(self):
        form = self.form_addbrand()
        if not form.validates():
            form.brand.value = clean_str(form.brand.value)
            return render.add_brand(form.render())
        else:
            newbrand = web.input().get("brand")
            newbrand = clean_str(form.brand.value)
            db.insert('brands', brand=newbrand)
            myglobals['brands'] = list(db.query("SELECT * FROM brands ORDER BY brand")) #refresh globals
        return render.add_brand(self.form_addbrand.render())

class about:
    def GET(self):
        return render.about()

class news:
    def GET(self):
        smartphones_data = db.query("SELECT s.model, s.display, s.power, s.battery, s.camera, s.id, b.brand, s.imagemini FROM smartphones AS s, brands AS b WHERE b.id = s.bid order by s.released DESC limit 5")
        return render.news(smartphones_data)

class reviews:
    def GET(self):
        reviews_data = list(db.select("reviews"))
        return render.reviews(reviews_data)

class review:
    def GET(self, permalink):
        reviews_data = list(db.select("reviews"))
        for review in reviews_data:
            if review['permalink'] == permalink:
                return render.review(review)
        raise web.seeother('/')

class brand:
    def GET(self, bid):
        bid = int(bid)
        brands = list(db.select("brands"))
        for b in brands:
            if b.id == bid:
                smartphones = list(db.query("SELECT s.id, s.model, s.imagemini, b.brand FROM smartphones AS s, brands AS b WHERE s.bid = $bid AND s.bid = b.id", vars=locals()))
        if smartphones == []: raise web.seeother('/')
        return render.brand(smartphones)

class populars:
    def GET(self):
        smartphones_data = db.query("SELECT s.model, s.display, s.power, s.battery, s.camera, s.id, b.brand, s.imagemini FROM smartphones AS s, brands AS b WHERE b.id = s.bid and s.popular = 1")
        return render.populars(smartphones_data)

if __name__ == "__main__":
    app = web.application(urls, globals())
    web.httpserver.runsimple(app.wsgifunc(), ("127.0.0.1", 3000))
