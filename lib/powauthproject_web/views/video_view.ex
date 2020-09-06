defmodule PowauthprojectWeb.VideoView do
  use PowauthprojectWeb, :view


  def category_select_options(categories) do
    for category <- categories, do: {category.name, category.id}
  end
end
