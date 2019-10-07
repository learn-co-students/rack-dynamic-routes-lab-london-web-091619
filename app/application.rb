require "pry"

class Application
  @@items = []
  fig = Item.new("Figs", 3.42)
  pear = Item.new("Pears", 0.99)
  @@items << fig
  @@items << pear

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if item = @@items.find { |i| i.name == item_name }
        resp.write item.price
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end
