# Protocol-oriented programming for UI customize

這是一個demo，用來展示protcol導向的UI開發方式，其中包含兩個展示元件：

1. 一個只要設定 URL後即會自動捉取遠端圖片並更新的 UIImageView subclass，主要用於 avatar
2. 一個可依照顯示區域大小不同，而秀出不同資訊的class，其本身實現了獲取遠端JSON資料的protocol
