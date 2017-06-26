class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      #Turn /items/[item_name] into item_name
      item_name = req.path.split("/items/").last
      resp.write get_item_price(item_name, resp)
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish

  end

  def get_item_price(item_name, resp)
    item = Item.all.find{|item| item.name == item_name}
    if item
      item.price
    else
      resp.status = 400
      "Item not found"
    end
  end


end
