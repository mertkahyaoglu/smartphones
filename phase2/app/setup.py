import web
from data import smartphones, reviews

urls = (
    '/', 'index',
    '/smartphones', 'smartphones',
    '/smartphone/(.*)/(.*)', 'smartphone',
    '/about', 'about',
    '/news', 'news',
    '/populars', 'populars',
    '/reviews', 'reviews',
    '/review/(.*)', 'review'
)

# data comes from data.py
smartphones_data = smartphones
reviews_data = reviews

render = web.template.render('templates/', base='base')

class index:
    def GET(self):
    	return render.index(smartphones_data, reviews_data)

class smartphones:
    def GET(self):
    	return render.smartphones(smartphones_data)

class smartphone:
    def GET(self, sf_name, sf_id):
        sf = smartphones_data[int(sf_id)]  
    	return render.smartphone(sf)

class about:
    def GET(self):
    	return render.about()

class news:
    def GET(self):
        return render.news()

class reviews:
    def GET(self):
        return render.reviews(reviews_data)

class review:
    def GET(self, permalink):
        for review in reviews_data:
            if review['permalink'] == permalink:
                return render.review(review)            

class populars:
    def GET(self):
        return render.populars()

if __name__ == "__main__":
    app = web.application(urls, globals())
    web.httpserver.runsimple(app.wsgifunc(), ("127.0.0.1", 3000))
