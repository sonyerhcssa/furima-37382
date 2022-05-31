crumb :root do
  link "Home", root_path
end

crumb :item_show do |item|
  link "商品詳細", item_path(item)
  parent :root
end

crumb :item_purchases do |item|
  link "商品購入", item_purchases_path
  parent :item_show, item
end

crumb :user_sessions do
  link "ログイン", root_path
  parent :root
end

crumb :user_registrations do
  link "会員登録", root_path
  parent :root
end

crumb :item_search do
  link "検索結果", root_path
  parent :root
end

crumb :card_new do
  link "マイページ", root_path
  parent :root
end