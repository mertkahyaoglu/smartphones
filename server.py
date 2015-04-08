# -*- coding: utf-8 -*-
import web
from data.smartphones import smartphones_data
from data.reviews import reviews_data

brands = sorted(set( s['brand'] for s in smartphones_data))

urls = (
    '/', 'index',
    '/smartphones', 'smartphones',
    '/smartphone/(.*)/(.*)', 'smartphone',
    '/news', 'news',
    '/populars', 'populars',
    '/reviews', 'reviews',
    '/review/(.*)', 'review',
    '/brand/(.*)', 'brand',
    '/search', 'search'
)

""" GLOBALS """
myglobals = {
   'brands' : brands,
   'menu' : [
        ("/", "home"),
        ("/smartphones", "smartphones"),
        ("/news", "news"),
        ("/populars", "populars"),
        ("/reviews", "reviews")
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
        return render.index(smartphones_data, reviews_data)

class search:
    def GET(self):
        inp = web.input()
        search = inp.get("search", None).lower()
        results = []
        if search == None:
            raise web.seeother('/')
        for s in smartphones_data:
            model = s['model'].lower()
            brand = s['brand'].lower()
            search_keys = search.split()

            if len(search_keys) > 1:
                if search_keys[0] in model or search_keys[1] in model:
                    results.append(s)
            else:
                if search in model:
                    results.append(s)
                elif search in brand:
                    results.append(s)
        return render.search(results);

class smartphones:
    def GET(self):
        inp = web.input()

        """Filtering"""
        sfilter = inp.get("smartphones_by_brand", None)
        if sfilter == None or sfilter == "all":
            return_data = smartphones_data
        else:
            return_data = []
            for s in smartphones_data:
                if s['brand'] == sfilter:
                    return_data.append(s)

        """Pagination"""
        page = int(inp.page) if hasattr(inp, 'page') else 1
        pagesize = 4
        totalpages = len(return_data)/pagesize
        start, end = get_slices(page, pagesize)
        return render.smartphones(return_data[start:end], brands, page, totalpages)

class smartphone:
    def GET(self, sname, sid):
        sid = int(sid)
        s_item = smartphones_data[sid-1]
        if s_item:
            item_images = s_item['images'] if s_item.has_key('images') else []
            return render.smartphone(s_item, item_images)
        else: raise web.seeother('/')

class news:
    def GET(self):
        return render.news(smartphones_data[:4])

class reviews:
    def GET(self):
        return render.reviews(reviews_data)

class review:
    def GET(self, permalink):
        for review in reviews_data:
            if review['permalink'] == permalink:
                return render.review(review)
        raise web.seeother('/')

class brand:
    def GET(self, brand):
        smartphones = [ s for s in smartphones_data if s['brand'] == brand ]
        if smartphones == []: raise web.seeother('/')
        return render.brand(smartphones)

class populars:
    def GET(self):
        populars = []
        for s in smartphones_data:
            if s['popular']:
                populars.append(s)
        return render.populars(populars)

if __name__ == "__main__":
    app = web.application(urls, globals())
    app.run()
