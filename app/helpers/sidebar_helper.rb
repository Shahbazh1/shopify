module SidebarHelper
  def sidebar_icon(name)
    icons = {
      home: "fa-house",
      orders: "fa-box",
      products: "fa-bag-shopping",
      customers: "fa-users",
      discounts: "fa-tag",
      collections: "fa-layer-group",
      inventory: "fa-warehouse",
      settings: "fa-gear",
      store: "fa-store",
      draft: "fa-file",
      checkout: "fa-cart-shopping",
      segments: "fa-filter"
    }

    icon_class = icons[name.to_sym] || "fa-circle"

    content_tag(:i, "", class: "fa-solid #{icon_class}")
  end
end