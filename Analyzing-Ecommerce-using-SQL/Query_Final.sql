-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.customer
(
    customer_id character varying COLLATE pg_catalog."default",
    customer_unique_id character varying COLLATE pg_catalog."default",
    customer_zip_code_prefix integer,
    customer_city character varying COLLATE pg_catalog."default",
    customer_state character varying COLLATE pg_catalog."default",
    PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS public.geolocation
(
    zip_code_prefix character varying COLLATE pg_catalog."default",
    lat character varying COLLATE pg_catalog."default",
    lng character varying COLLATE pg_catalog."default",
    city character varying COLLATE pg_catalog."default",
    state character varying COLLATE pg_catalog."default",
    PRIMARY KEY (zip_code_prefix)
);

CREATE TABLE IF NOT EXISTS public.order_item
(
    order_id character varying COLLATE pg_catalog."default",
    order_item_id character varying COLLATE pg_catalog."default",
    product_id character varying COLLATE pg_catalog."default",
    seller_id character varying COLLATE pg_catalog."default",
    shipping_limit_date date,
    price double precision,
    freight_value double precision,
    PRIMARY KEY (order_item_id)
);

CREATE TABLE IF NOT EXISTS public.order_payments
(
    order_id character varying COLLATE pg_catalog."default",
    payment_sequential integer,
    payment_type character varying COLLATE pg_catalog."default",
    payment_installments integer,
    payment_value double precision
);

CREATE TABLE IF NOT EXISTS public.order_reviews
(
    review_id character varying COLLATE pg_catalog."default",
    order_id character varying COLLATE pg_catalog."default",
    review_score character varying COLLATE pg_catalog."default",
    review_comment_title character varying COLLATE pg_catalog."default",
    review_comment_message character varying COLLATE pg_catalog."default",
    review_creation_date date,
    review_answer_timestamp character varying COLLATE pg_catalog."default",
    PRIMARY KEY (review_id)
);

CREATE TABLE IF NOT EXISTS public.orders
(
    order_id character varying COLLATE pg_catalog."default",
    customer_id character varying COLLATE pg_catalog."default",
    order_status character varying COLLATE pg_catalog."default",
    order_purchase_timestamp time without time zone,
    order_approved_at time without time zone,
    order_delivered_carrier_date time without time zone,
    order_delivered_customer_date time without time zone,
    order_estimated_delivery_date time without time zone,
    PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS public.product
(
    index_col integer,
    product_id character varying COLLATE pg_catalog."default",
    product_category_name character varying COLLATE pg_catalog."default",
    product_name_length double precision,
    product_description_length double precision,
    product_photos_qty double precision,
    product_weight_g double precision,
    product_length_cm double precision,
    product_height_cm double precision,
    product_width_cm double precision,
    PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS public.sellers
(
    seller_id character varying COLLATE pg_catalog."default",
    seller_zip integer,
    seller_city character varying COLLATE pg_catalog."default",
    seller_state character varying COLLATE pg_catalog."default",
    PRIMARY KEY (seller_id)
);

ALTER TABLE IF EXISTS public.customer
    ADD FOREIGN KEY (customer_zip_code_prefix)
    REFERENCES public.geolocation (zip_code_prefix) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_item
    ADD FOREIGN KEY (product_id)
    REFERENCES public.product (product_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_item
    ADD FOREIGN KEY (seller_id)
    REFERENCES public.sellers (seller_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_item
    ADD FOREIGN KEY (order_id)
    REFERENCES public.orders (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_payments
    ADD FOREIGN KEY (order_id)
    REFERENCES public.orders (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_reviews
    ADD FOREIGN KEY (order_id)
    REFERENCES public.orders (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders
    ADD FOREIGN KEY (customer_id)
    REFERENCES public.customer (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.sellers
    ADD FOREIGN KEY (seller_zip)
    REFERENCES public.geolocation (zip_code_prefix) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;