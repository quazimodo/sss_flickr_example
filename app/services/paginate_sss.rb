class PaginateSss

  attr_accessor :page, :pages, :params

  def initialize(obj, params = {}, page_method = :page, pages_method = :pages)
    @obj = obj
    @params = params.except "action", "controller"
    @page = obj.send(page_method).to_i
    @pages = obj.send(pages_method).to_i
  end

  def url_for(p)
    case p
    when :last
      p = pages
    when :first
      p = 1
    end
    h1 = { "page" => p, "commit" => "paginate_#{p}" }
    h2 = params.merge(h1)

    "/search?" + h2.map{|k,v| "#{k}=#{v}"}.join("&")
  end

  def start_page
    [1, page - 5].max
  end

  def end_page
    [page + 5, pages].min
  end
end
