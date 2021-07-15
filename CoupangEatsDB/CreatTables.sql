-- user Table Create SQL
CREATE TABLE user
(
    `id`         INT            NOT NULL    AUTO_INCREMENT COMMENT '사용자id', 
    `name`       VARCHAR(45)    NOT NULL    COMMENT '사용자 이름', 
    `location`   VARCHAR(45)    NOT NULL    COMMENT '위치', 
    `createdAt`  TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`  TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
    `status`     BIT            NOT NULL    DEFAULT 0 COMMENT '0: 활성, 1: 비활성', 
    `email`      VARCHAR(45)    NOT NULL    COMMENT '이메일', 
    `sex`        BIT            NOT NULL    COMMENT '0: 남, 1: 여', 
    `phoneNum`   VARCHAR(45)    NOT NULL    COMMENT '전화번호', 
     PRIMARY KEY (id)
);

ALTER TABLE user COMMENT '사용자';


-- delivery Table Create SQL
CREATE TABLE delivery
(
    `id`         INT          NOT NULL    AUTO_INCREMENT COMMENT '배달부 id', 
    `status`     BIT          NOT NULL    DEFAULT 0 COMMENT '0: 기본 배달, 1: 치타 배달', 
    `createdAt`  TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`  TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
     PRIMARY KEY (id)
);

ALTER TABLE delivery COMMENT '배달부';


-- cart Table Create SQL
CREATE TABLE cart
(
    `Id`         INT          NOT NULL    AUTO_INCREMENT COMMENT '카트 id', 
    `userId`     INT          NOT NULL    COMMENT '사용자id', 
    `createdAt`  TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`  TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
    `status`     BIT          NOT NULL    DEFAULT 0 COMMENT '0: 정상, 1: 취소', 
     PRIMARY KEY (Id)
);

ALTER TABLE cart COMMENT '카트';

ALTER TABLE cart
    ADD CONSTRAINT FK_cart_userId_user_id FOREIGN KEY (userId)
        REFERENCES user (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- restaurant Table Create SQL
CREATE TABLE restaurant
(
    `id`         INT            NOT NULL    AUTO_INCREMENT COMMENT '식당 id', 
    `name`       VARCHAR(45)    NOT NULL    COMMENT '식당 이름', 
    `location`   VARCHAR(45)    NOT NULL    COMMENT '위치', 
    `createdAt`  TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '등록된날짜', 
    `updatedAt`  TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '수정된날짜', 
    `minCost`    INT            NOT NULL    COMMENT '최소주문금액', 
    `info`       TEXT           NOT NULL    COMMENT '매장 소개', 
    `status`     BIT            NOT NULL    DEFAULT 0 COMMENT '0: 오픈, 1: 마감', 
     PRIMARY KEY (id)
);

ALTER TABLE restaurant COMMENT '식당';


-- menu Table Create SQL
CREATE TABLE menu
(
    `id`            INT            NOT NULL    AUTO_INCREMENT COMMENT '음식 id', 
    `name`          VARCHAR(45)    NOT NULL    COMMENT '음식 이름', 
    `restaurantId`  INT            NOT NULL    COMMENT '어떤 식당에 있는 음식인가?', 
    `imageUrl`      TEXT           NOT NULL    COMMENT '음식 사진', 
    `contents`      TEXT           NOT NULL    COMMENT '음식 설명', 
    `createdAt`     TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`     TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
    `status`        BIT            NOT NULL    DEFAULT 0 COMMENT '0: 가능, 1: 불가능', 
     PRIMARY KEY (id)
);

ALTER TABLE menu COMMENT '메뉴';

ALTER TABLE menu
    ADD CONSTRAINT FK_menu_restaurantId_restaurant_id FOREIGN KEY (restaurantId)
        REFERENCES restaurant (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- orders Table Create SQL
CREATE TABLE orders
(
    `id`          INT          NOT NULL    AUTO_INCREMENT COMMENT '주문 id', 
    `userId`      INT          NOT NULL    COMMENT '사용자id', 
    `cartId`      INT          NOT NULL    COMMENT '카트 id', 
    `deliveryId`  INT          NOT NULL    COMMENT '배달부 id', 
    `request`     TEXT         NOT NULL    COMMENT '요청 사항', 
    `couponId`    INT          NOT NULL    COMMENT '쿠폰 id', 
    `createdAt`   TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '주문 날짜', 
    `updatedAt`   TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '주문 수정 날짜', 
    `status`      BIT          NOT NULL    DEFAULT 0 COMMENT '0: 정상, 1: 취소', 
     PRIMARY KEY (id)
);

ALTER TABLE orders COMMENT '주문';

ALTER TABLE orders
    ADD CONSTRAINT FK_orders_userId_user_id FOREIGN KEY (userId)
        REFERENCES user (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE orders
    ADD CONSTRAINT FK_orders_cartId_cart_Id FOREIGN KEY (cartId)
        REFERENCES cart (Id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE orders
    ADD CONSTRAINT FK_orders_deliveryId_delivery_id FOREIGN KEY (deliveryId)
        REFERENCES delivery (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- cartedmenu Table Create SQL
CREATE TABLE cartedmenu
(
    `id`            INT          NOT NULL    AUTO_INCREMENT COMMENT 'id', 
    `cartId`        INT          NOT NULL    COMMENT '카트 id', 
    `menuId`        INT          NOT NULL    COMMENT '음식 id', 
    `restaurantId`  INT          NOT NULL    COMMENT '식당 id', 
    `createdAt`     TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`     TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
    `status`        BIT          NOT NULL    DEFAULT 0 COMMENT '0: 가능, 1: 불가능', 
     PRIMARY KEY (id)
);

ALTER TABLE cartedmenu COMMENT '카트에 담긴 메뉴';

ALTER TABLE cartedmenu
    ADD CONSTRAINT FK_cartedmenu_cartId_cart_Id FOREIGN KEY (cartId)
        REFERENCES cart (Id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE cartedmenu
    ADD CONSTRAINT FK_cartedmenu_menuId_menu_id FOREIGN KEY (menuId)
        REFERENCES menu (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE cartedmenu
    ADD CONSTRAINT FK_cartedmenu_restaurantId_restaurant_id FOREIGN KEY (restaurantId)
        REFERENCES restaurant (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- favorites Table Create SQL
CREATE TABLE favorites
(
    `id`            INT          NOT NULL    AUTO_INCREMENT, 
    `userId`        INT          NOT NULL    COMMENT '사용자id', 
    `restaurantId`  INT          NOT NULL    COMMENT '식당 id', 
    `createdAt`     TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`     TIMESTAMP    NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
    `status`        BIT          NOT NULL    DEFAULT 0 COMMENT '0: 활성, 1: 비활성', 
     PRIMARY KEY (id)
);

ALTER TABLE favorites COMMENT '즐겨찾기';

ALTER TABLE favorites
    ADD CONSTRAINT FK_favorites_userId_user_id FOREIGN KEY (userId)
        REFERENCES user (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE favorites
    ADD CONSTRAINT FK_favorites_restaurantId_restaurant_id FOREIGN KEY (restaurantId)
        REFERENCES restaurant (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- category Table Create SQL
CREATE TABLE category
(
    `id`            INT            NOT NULL    AUTO_INCREMENT COMMENT '카테고리 id', 
    `name`          VARCHAR(45)    NOT NULL    COMMENT '카테고리 이름', 
    `restaurantId`  INT            NOT NULL    COMMENT '식당 id', 
    `createdAt`     TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`     TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
    `status`        BIT            NOT NULL    DEFAULT 0 COMMENT '0: 활성, 1: 비활성', 
     PRIMARY KEY (id)
);

ALTER TABLE category COMMENT '카테고리';

ALTER TABLE category
    ADD CONSTRAINT FK_category_restaurantId_restaurant_id FOREIGN KEY (restaurantId)
        REFERENCES restaurant (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- review Table Create SQL
CREATE TABLE review
(
    `id`            INT             NOT NULL    AUTO_INCREMENT COMMENT '리뷰 id', 
    `orderId`       INT             NOT NULL    COMMENT '주문 id', 
    `restaurantId`  INT             NOT NULL    COMMENT '리뷰를 받은 식당', 
    `imageUrl`      TEXT            NOT NULL    COMMENT '음식 사진', 
    `contents`      TEXT            NOT NULL    COMMENT '리뷰 내용', 
    `score`         INT UNSIGNED    NOT NULL    COMMENT '별졈(점수)', 
    `createdAt`     TIMESTAMP       NOT NULL    DEFAULT current_timestamp COMMENT '등록 날짜', 
    `updatedAt`     TIMESTAMP       NOT NULL    DEFAULT current_timestamp COMMENT '수정 날짜', 
    `status`        BIT             NOT NULL    DEFAULT 0 COMMENT '0: 활성, 1: 삭제', 
     PRIMARY KEY (id)
);

ALTER TABLE review COMMENT '리뷰';

ALTER TABLE review
    ADD CONSTRAINT FK_review_restaurantId_restaurant_id FOREIGN KEY (restaurantId)
        REFERENCES restaurant (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE review
    ADD CONSTRAINT FK_review_orderId_orders_id FOREIGN KEY (orderId)
        REFERENCES orders (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- coupon Table Create SQL
CREATE TABLE coupon
(
    `id`         INT            NOT NULL    AUTO_INCREMENT COMMENT '쿠폰 id', 
    `name`       VARCHAR(45)    NOT NULL    COMMENT '쿠폰 이름', 
    `userId`     INT            NOT NULL    COMMENT '이 쿠폰을 가진 사용자', 
    `benefits`   VARCHAR(45)    NOT NULL    COMMENT '쿠폰 혜택', 
    `createdAt`  TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '쿠폰 등록날짜', 
    `updatedAt`  TIMESTAMP      NOT NULL    DEFAULT current_timestamp COMMENT '쿠폰 수정날짜', 
    `status`     BIT            NOT NULL    DEFAULT 0 COMMENT '0: 사용전, 1: 사용후', 
     PRIMARY KEY (id)
);

ALTER TABLE coupon COMMENT '쿠폰';

ALTER TABLE coupon
    ADD CONSTRAINT FK_coupon_userId_user_id FOREIGN KEY (userId)
        REFERENCES user (id) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- Add column
ALTER TABLE restaurant ADD `delCost` TEXT NOT NULL COMMENT'배달비';
ALTER TABLE restaurant ADD `imageUrl` TEXT NOT NULL COMMENT'식당사진';
ALTER TABLE category ADD `imagUrl` TEXT NOT NULL COMMENT'카테고리사진';
ALTER TABLE menu ADD `cost` TEXT NOT NULL COMMENT'카테고리사진';
ALTER TABLE restaurant ADD `delTime` TEXT NOT NULL COMMENT'배달시간';
