import web

urls = (
    '/', 'index',
    '/smartphones', 'smartphones',
    '/smartphone/(.*)/(.*)', 'smartphone',
    '/about', 'about'
)

data = [
    {
        "img": "/static/img/item.jpg",
        "brand": "Apple",
        "model": "iPhone 6",
        "display": "4.7\" IPS Display",
        "chipset": "A8 Dual-core 1.4 Ghz",
        "camera": "8.0MP Isight Camera",
        "battery": "1850Mah Battery"
    },
    {   
        "img": "/static/img/item2.jpg",
        "brand": "Samsung",
        "model": "Note 4",
        "display": "5.7\" IPS Display",
        "chipset": "Qualcomm Snapdragon Quad-core 2.7 Ghz",
        "camera": "16.0MP Camera",
        "battery": "3220Mah Battery"
    },
    {   
        "img": "/static/img/item3.jpg",
        "brand": "Sony",
        "model": "Z3",
        "display": "5.2\" IPS Display",
        "chipset": "Qualcomm Snapdragon Quad-core 2.5 Ghz",
        "camera": "21.0MP Camera",
        "battery": "3200Mah Battery"
    },
    {   
        "img": "/static/img/item4.jpg",
        "brand": "LG",
        "model": "G3",
        "display": "5.5\" IPS Display",
        "chipset": "Qualcomm Snapdragon Quad-core 2.3 Ghz",
        "camera": "13.0MP Camera",
        "battery": "3000Mah Battery"
    },
    {   
        "img": "/static/img/item5.jpg",
        "brand": "Google",
        "model": "Nexus",
        "display": "5.9\" IPS Display",
        "chipset": "Qualcomm Snapdragon Quad-core 2.7 Ghz",
        "camera": "13.0MP Camera",
        "battery": "3000Mah Battery"
    }
]

render = web.template.render('templates/', base='layout')

class index:
    def GET(self):
    	return render.index()

class smartphones:
    def GET(self):
    	return render.smartphones(data)

class smartphone:
    def GET(self, sf_name, sf_id):
        sf = data[int(sf_id)]  
    	return render.smartphone(sf)

class about:
    def GET(self):
    	return render.about()

if __name__ == "__main__":
    app = web.application(urls, globals())
    web.httpserver.runsimple(app.wsgifunc(), ("127.0.0.1", 3000))
