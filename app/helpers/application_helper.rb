module ApplicationHelper
  include Pagy::Frontend

  def orderable(column, temp, title = nil)
    title = column.titleize if title.nil?
    css_class = (column == sort_column(temp) ? "current #{sort_direction}" : nil)
    direction = (column == sort_column(temp) && sort_direction == 'desc' ? 'asc' : 'desc')
    link_to title, { sort: column, direction: direction, search_key: params[:search_key] }
  end
end
