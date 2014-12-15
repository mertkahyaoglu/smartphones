import web

urls = (
    '/', 'index',
    '/smartphones', 'smartphones',
    '/smartphone/(.*)/(.*)', 'smartphone',
    '/about', 'about',
    '/news', 'news',
    '/populars', 'populars',
    '/reviews', 'reviews',
    '/review/(.*)', 'review',
    '/brand/(.*)', 'brand'
)

db = web.database(dbn='mysql', user='root', pw='', host="127.0.0.1", port=3306, db='smartphones')

myglobals = {
   'brands' : list(db.select("brands")),
   'menu' : [
        ("/", "home"),
        ("/smartphones", "smartphones"),
        ("/news", "news"),
        ("/populars", "populars"),
        ("/reviews", "reviews"),
        ("/about", "about")
    ]
}

render = web.template.render('templates/', base='base', globals=myglobals)

class index:
    def GET(self):
        smartphones_data = list(db.query("SELECT * FROM smartphones AS s, brands AS b WHERE b.id = s.id"))
        reviews_data = list(db.select("reviews"))
        return render.index(smartphones_data, reviews_data)

class smartphones:
    def GET(self):
        smartphones_data = list(db.query("SELECT s.id, s.model, s.battery, s.imagemini, b.brand, d.size, f.cpu, c.primary FROM smartphones AS s, brands AS b, display AS d, camera AS c, features AS f WHERE b.id = s.bid AND d.id = s.id AND c.id = s.id AND f.id = s.id"))
        return render.smartphones(smartphones_data)

class smartphone:
    def GET(self, sname, sid):
        sid = int(sid)
        s_item = db.query("SELECT * FROM smartphones AS s, brands AS b, display AS d, camera AS c, features AS f WHERE s.id = $sid AND b.id = $sid AND d.id = $sid AND c.id = $sid AND f.id = $sid", vars=locals())
        if s_item:
            item_images = list(db.select("images", where="sid=$sid", vars=locals()))
            return render.smartphone(s_item[0], item_images)
        else: raise web.seeother('/')

class about:
    def GET(self):
        return render.about()

class news:
    def GET(self):
        return render.news()

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
        return render.populars()

if __name__ == "__main__":
    app = web.application(urls, globals())
    web.httpserver.runsimple(app.wsgifunc(), ("127.0.0.1", 3000))
