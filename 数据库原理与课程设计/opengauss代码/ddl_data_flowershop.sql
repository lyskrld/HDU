

-- Name: liuhongkun; Type: Schema; Schema:  ;

CREATE SCHEMA liuhongkun;



SET search_path = liuhongkun ;



-- Name: liuhongkun; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON SCHEMA liuhongkun FROM PUBLIC;
 REVOKE ALL ON SCHEMA liuhongkun FROM liuhongkun;
GRANT ALL ON SCHEMA liuhongkun TO liuhongkun;
GRANT USAGE ON SCHEMA liuhongkun TO cs_staff;
GRANT USAGE ON SCHEMA liuhongkun TO logistics_staff;
GRANT USAGE ON SCHEMA liuhongkun TO sales_staff;
GRANT USAGE ON SCHEMA liuhongkun TO supplier;
GRANT USAGE ON SCHEMA liuhongkun TO d_header;
GRANT USAGE ON SCHEMA liuhongkun TO seller;
GRANT USAGE ON SCHEMA liuhongkun TO customer;
GRANT USAGE ON SCHEMA liuhongkun TO cx;
GRANT USAGE ON SCHEMA liuhongkun TO chenxu;


-- Name: add_new_flower; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.add_new_flower(p_flonum character, p_floname character varying, p_color character varying, p_unit character varying, p_price integer, p_warenum character, p_number integer)
AS  DECLARE 
BEGIN
    -- 检查鲜花编号是否已经存在
    IF EXISTS (SELECT 1 FROM flower WHERE flonum = p_flonum) THEN
        RAISE EXCEPTION '鲜花编号 % 已经存在', p_flonum;
    END IF;

    -- 检查仓库编号是否存在
    IF NOT EXISTS (SELECT 1 FROM warehouse WHERE warenum = p_warenum) THEN
        RAISE EXCEPTION '仓库编号 % 不存在', p_warenum;
    END IF;

    -- 检查价格是否为正数
    IF p_price <= 0 THEN
        RAISE EXCEPTION '价格必须为正数';
    END IF;

    -- 检查数量是否为正数
    IF p_number < 0 THEN
        RAISE EXCEPTION '数量不能为负数';
    END IF;

    -- 插入新的鲜花记录
    INSERT INTO flower (flonum, floname, color, unit, price, warenum, "number")
    VALUES (p_flonum, p_floname, p_color, p_unit, p_price, p_warenum, p_number);

    -- 提示插入成功
    RAISE NOTICE '成功插入新的鲜花记录: %', p_flonum;
END;
/
/

-- Name: calculate_discount_amount; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.calculate_discount_amount()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    disc_value DOUBLE PRECISION;
    item_price DOUBLE PRECISION;
BEGIN
    -- 获取商品价格
    SELECT price INTO item_price
    FROM Item
    WHERE Itemnum = NEW.Itemnum;

    -- 当折扣编号为空时，折扣价为原价
    IF NEW.Discnum ='000' THEN
        NEW.discamount := NEW.Number * item_price;
    ELSE
        -- 获取折扣值
        SELECT Discvalue INTO disc_value
        FROM Discount
        WHERE Discnum = NEW.Discnum;

        -- 计算折扣价
        IF disc_value > 0 AND disc_value <= 1 THEN
            -- 当折扣值为0-1时，折扣价为商品订购数量 * 商品单价 * 折扣值
            NEW.discamount := NEW.Number * item_price * disc_value;
        ELSIF disc_value > 1 AND disc_value % 5 = 0 THEN
            -- 当折扣值为5的倍数时，折扣价为商品订购数量 * 商品单价 - 折扣值
            NEW.discamount := NEW.Number * item_price - disc_value;
        ELSE
            -- 其他情况抛出异常
            RAISE EXCEPTION 'Invalid discount value.';
        END IF;
    END IF;

    -- 检查折扣价是否非负
    IF NEW.discamount < 0 THEN
        RAISE EXCEPTION '折扣价不能为负数.';
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: calculate_member_discount; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.calculate_member_discount()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE 
item_class VARCHAR(20);
item_price DOUBLE PRECISION;
BEGIN
    -- 检查折扣编号是否为会员折扣
    IF NEW.discnum = '001' THEN
        -- 获取商品种类
        SELECT class,price INTO item_class, item_price
        FROM Item
        WHERE itemnum = NEW.itemnum;
        
        -- 根据商品种类应用不同的会员折扣
        CASE item_class
            WHEN '爱情' THEN
                NEW.discamount := NEW.Number * item_price * 0.90; -- 九折
            WHEN '亲情' THEN
                NEW.discamount := NEW.Number * item_price * 0.87; -- 八七折
            WHEN '友情' THEN
                NEW.discamount := NEW.Number * item_price * 0.87; -- 八七折
            WHEN '生日' THEN
                NEW.discamount := NEW.Number * item_price * 0.88; -- 八八折
            WHEN '祝福' THEN
                NEW.discamount := NEW.Number * item_price * 0.88; -- 八八折
            WHEN '周年纪念' THEN
                NEW.discamount := NEW.Number * item_price * 0.88; -- 八八折
            ELSE
                NEW.discamount := NEW.Number * item_price * 0.95; -- 九五折
        END CASE;
    END IF;
    
    RETURN NEW;
END;
$$;
/

-- Name: calculate_salary_increase; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.calculate_salary_increase()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    experience_years INTEGER;
    salary_increase INTEGER;
BEGIN
    -- 计算工龄，以年为单位
    experience_years := EXTRACT(YEAR FROM age(now(), NEW.Entrydate));
    
    -- 根据工龄计算薪资增加，每年增加500，最多增加到2000
    salary_increase := LEAST(experience_years * 500, 2000);
    
    -- 设置新的薪资
    NEW.salary := 5000 + salary_increase;
    
    RETURN NEW;
END;
$$;
/

-- Name: calculate_salary_increase; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.calculate_salary_increase(entry_date timestamp without time zone)
 RETURNS integer
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    experience_years INTEGER;
    salary_increase INTEGER;
BEGIN
    -- 计算工龄，以年为单位
    experience_years := EXTRACT(YEAR FROM age(now(), entry_date));
    
    -- 根据工龄计算薪资增加，每年增加500，最多增加到2000
    salary_increase := LEAST(experience_years * 500, 2000);
    
    -- 返回计算出的薪资增加额
    RETURN salary_increase;
END;
$$;
/

-- Name: check_customer_order_status; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.check_customer_order_status(customer_id character)
AS 
DECLARE
    order_status varchar(10);
    customer_name varchar(20);
    order_time timestamp;
BEGIN
    -- 获取顾客姓名
    SELECT custname INTO customer_name
    FROM customer
    WHERE custnum = customer_id;

    -- 获取顾客的订单状态和下单时间
    SELECT paystate, ordertime INTO order_status, order_time
    FROM "Order"
    WHERE custnum = customer_id 
    AND ordertime >= CURRENT_TIMESTAMP - INTERVAL '24 hours';

    -- 检查订单状态并发送通知
    IF order_status = '否' AND CURRENT_TIMESTAMP - order_time > INTERVAL '30 minutes' THEN
        -- 如果订单状态为“否”且超过30分钟未支付，发送警告邮件给顾客
        RAISE NOTICE '尊敬的 %，您的订单尚未完成支付，请尽快完成支付。', customer_name;
    ELSIF order_status = '是' THEN
        -- 如果订单状态为“是”，发送确认邮件给顾客
        RAISE NOTICE '尊敬的 %，您的订单已成功支付并处理完成。感谢您的购买。', customer_name;
    ELSE
        -- 如果订单状态不明确，发送警告邮件给顾客
        RAISE NOTICE '尊敬的 %，您的订单状态似乎有问题，请联系客服支持以获取帮助。', customer_name;
    END IF;
END;
/
/

-- Name: check_customer_service_department; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.check_customer_service_department()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE emp_department_name VARCHAR(20);
BEGIN
    -- 如果员工编号为空，则直接返回
    IF NEW.Empnum IS NULL THEN
        RETURN NEW;
    END IF;
    
    -- 获取员工所在部门的部门名称
    SELECT Deptname INTO emp_department_name
    FROM Department d, Employee e
    WHERE e.Empnum = NEW.Empnum
    AND e.Deptnum=d.Deptnum;

    -- 检查员工所在部门是否为客服部
    IF emp_department_name != '客服部' THEN
        RAISE EXCEPTION 'The employee must belong to the Customer Service Department for evaluations.';
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: check_delivery_time; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.check_delivery_time()
AS 
DECLARE
    emp_name VARCHAR(50);
    cust_name VARCHAR(50);
    delivery_address VARCHAR(200);
    order_info RECORD;
    delivery_info RECORD;
BEGIN
    -- 获取所有发货时间为空的发货单
    FOR delivery_info IN SELECT * FROM invoice WHERE time IS NULL LOOP
    
        -- 获取员工姓名
        SELECT empname INTO emp_name FROM employee WHERE empnum = delivery_info.empnum;
        
        -- 获取顾客信息
        SELECT c.custname, c.receiveraddress INTO cust_name, delivery_address
        FROM "Order" o
        JOIN customer c ON o.custnum = c.custnum
        WHERE o.onum = delivery_info.onum;
        
        -- 获取订单信息
        SELECT * INTO order_info FROM "Order" WHERE onum = delivery_info.onum;
        
        -- 计算发货时间与订单下单时间的差值
        DECLARE
            time_diff INTERVAL;
        BEGIN
            time_diff := CURRENT_TIMESTAMP - order_info.ordertime;
            
            -- 如果发货时间与订单下单时间的差值超过3小时，则向员工发送警告
            IF time_diff > INTERVAL '3 hours' THEN
                -- 将订单和发货单的信息发送给员工
                RAISE NOTICE '警告：发货单%尚未发货，发货时间已超过订单%下单时间%，请%尽快发货',
                             delivery_info.invnum, order_info.onum, time_diff, emp_name;
                RAISE NOTICE '订单信息：顾客编号：%，顾客姓名：%，下单时间：%。',
                             order_info.custnum, cust_name, order_info.ordertime;
                RAISE NOTICE '发货单信息：发货单编号：%，发货方式：%，发货地址：%。',
                             delivery_info.invnum, delivery_info.transportation, delivery_address;
                RAISE NOTICE '-----------------------------------------------';
            END IF;
        END;
    END LOOP;
END;
/
/

-- Name: check_invoice_conditions; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.check_invoice_conditions()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    order_paystate VARCHAR(10);
    order_paytime TIMESTAMP;
BEGIN

    -- 获取订单的支付状态和支付时间
    SELECT paystate, paytime INTO order_paystate, order_paytime
    FROM "Order"
    WHERE Onum = NEW.Onum;

    -- 检查支付状态为“否”时，不允许创建发货单
    IF order_paystate = '否' THEN
        RAISE EXCEPTION '订单支付状态为“否”时，不允许创建发货单.';
    END IF;

    -- 检查支付状态为“是”时，发货时间必须晚于支付时间
    IF order_paystate = '是' AND NEW.time <= order_paytime THEN
        RAISE EXCEPTION '发货时间必须晚于支付时间.';
    END IF;

    -- 检查发货时间比支付时间超过3小时，并发出警告
    IF order_paystate = '是' AND NEW.time >= order_paytime + INTERVAL '3 hours' THEN
        RAISE WARNING '发货时间比支付时间晚3小时.';
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: check_logistics_department; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.check_logistics_department()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE emp_department_name VARCHAR(20);
BEGIN
    -- 如果员工编号为空，则直接返回
    IF NEW.Empnum IS NULL THEN
        RETURN NEW;
    END IF;
    
    -- 获取员工所在部门的部门名称
    SELECT Deptname INTO emp_department_name
    FROM Department d, Employee e
    WHERE e.Empnum = NEW.Empnum
    AND e.Deptnum=d.Deptnum;

    -- 检查员工所在部门是否为客服部
    IF emp_department_name != '物流部' THEN
        RAISE EXCEPTION 'The employee must belong to the Logistics Department for invoice.';
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: check_order_payment; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.check_order_payment()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
BEGIN
    -- 检查支付状态为“否”时，支付时间不能填写
    IF NEW.paystate = '否' AND NEW.paytime IS NOT NULL THEN
        RAISE EXCEPTION '支付状态为“否”时，不能填写支付时间.';
    END IF;

    -- 检查支付状态为“是”时，支付时间要晚于下单时间
    IF NEW.paystate = '是' AND NEW.paytime <= NEW.ordertime THEN
        RAISE EXCEPTION '支付时间必须晚于下单时间.';
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: check_order_quantity; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.check_order_quantity()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE order_paystate VARCHAR(10);
BEGIN
    -- 检查商品订购数量是否为正数
    IF NEW.number <= 0 THEN
        RAISE EXCEPTION '商品订购数量必须为正数';
    END IF;

    -- 检查商品订购数量是否大于商品库存数量，若大于则不能填写数据
    IF NEW.number > (
        SELECT Number FROM Item WHERE Itemnum = NEW.Itemnum
    ) THEN
        RAISE EXCEPTION '商品订购数量大于商品库存数量.';
    END IF;

	  -- 获取对应订单的支付状态
    SELECT paystate INTO order_paystate
    FROM "Order"
    WHERE "Order".onum=NEW.onum;
 
    -- 更新商品库存数量
    IF order_paystate = '是' THEN
      UPDATE Item
      SET Number = Number - NEW.number
      WHERE Itemnum = NEW.Itemnum;
	  END IF;

    RETURN NEW;
END;
$$;
/

-- Name: check_reply_time; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.check_reply_time()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    eval_time TIMESTAMP;
    reply_time TIMESTAMP;
BEGIN
    -- 获取评价时间
    eval_time := NEW.Evaltime;
	
	-- 检查回复时间是否晚于评价时间
IF NEW.Replytime IS NOT NULL THEN
		reply_time := NEW.Replytime;
	END IF;
IF eval_time > reply_time THEN
    RAISE EXCEPTION 'Reply time cannot be earlier than evaluation time.';
    		END IF;

    -- 检查员工回复时间是否比评价时间晚2天
    IF reply_time > eval_time + INTERVAL '2 days' THEN
        RAISE WARNING 'Employee reply time is more than 2 days after evaluation time.';
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: check_supplier_warehouse; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.check_supplier_warehouse()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
BEGIN
    -- 检查该供应商是否已经管理过仓库
    IF EXISTS (
        SELECT 1
        FROM Warehouse
        WHERE Supnum = NEW.Supnum
    ) THEN
        RAISE EXCEPTION '一个供应商只能管理一个仓库.';
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: get_provide_record; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.get_provide_record(p_supnum character, p_flonum character)
AS 
DECLARE
    provide_record RECORD;
BEGIN
    -- 查询供货记录的详细信息
    FOR provide_record IN
        SELECT p.flonum, f.floname, p.supnum, s.supname, w.warenum, p.bundlenumber, p.totalprice, p."time"
        FROM provide p
        JOIN flower f ON p.flonum = f.flonum
        JOIN supplier s ON p.supnum = s.supnum
        JOIN warehouse w ON w.warenum=f.warenum
        WHERE p.supnum = p_supnum AND p.flonum = p_flonum
    LOOP
        -- 输出供货记录信息
        RAISE NOTICE '鲜花编号: %, 鲜花名称: %, 供应商编号: %, 供应商名称: %, 仓库编号: %, 供货束数: %, 总价: %, 时间: %',
            provide_record.flonum, provide_record.floname, provide_record.supnum, provide_record.supname,
            provide_record.warenum, provide_record.bundlenumber, provide_record.totalprice, provide_record."time";
    END LOOP;
END;
/
/

-- Name: insert_employee; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.insert_employee(p_empnum character, p_empname character varying, p_deptnum character, p_contactnumber character varying, p_entrydate timestamp without time zone, p_birth timestamp without time zone, p_address character varying, p_password character varying, p_email character varying, p_salary integer)
AS  DECLARE 
BEGIN
    -- 检查员工编号是否已存在
    IF EXISTS (SELECT 1 FROM employee WHERE empnum = p_empnum) THEN
        RAISE EXCEPTION '员工编号已存在: %', p_empnum;
    END IF;

    -- 检查部门编号是否存在
    IF NOT EXISTS (SELECT 1 FROM department WHERE deptnum = p_deptnum) THEN
        RAISE EXCEPTION '部门编号不存在: %', p_deptnum;
    END IF;

    -- 插入新员工数据
    INSERT INTO employee (
        empnum, empname, deptnum, contactnumber, entrydate, birth, address, password, email, salary
    ) VALUES (
        p_empnum, p_empname, p_deptnum, p_contactnumber, p_entrydate, p_birth, p_address, p_password, p_email, p_salary
    );

    -- 打印成功信息
    RAISE NOTICE '成功插入员工: %', p_empname;
END;
/
/

-- Name: insert_evaluation; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.insert_evaluation(p_onum character, p_itemnum character, p_evalcontent character varying, p_evaltime timestamp without time zone)
AS  DECLARE 
BEGIN
    -- 检查订单编号是否存在
    IF NOT EXISTS (SELECT 1 FROM "Order" WHERE onum = p_onum) THEN
        RAISE EXCEPTION '订单编号不存在: %', p_onum;
    END IF;

    -- 检查商品编号是否存在
    IF p_itemnum IS NOT NULL AND NOT EXISTS (SELECT 1 FROM "ApplyDisc" a WHERE p_onum = a.onum and itemnum = p_itemnum) THEN
        RAISE EXCEPTION '商品编号不存在: %', p_itemnum;
    END IF;

    -- 插入评价数据
    INSERT INTO evaluate (
        onum, itemnum, evalcontent, evaltime
    ) VALUES (
        p_onum, p_itemnum, p_evalcontent, p_evaltime
    );

    -- 检查是否成功插入评价数据
    IF NOT FOUND THEN
        RAISE EXCEPTION '插入评价数据失败: 订单编号 = %, 商品编号= % ',p_onum, p_itemnum;
    END IF;

    -- 返回插入数据的信息
    RAISE NOTICE '成功插入评价数据: 订单编号 = %, 商品编号= % ',p_onum, p_itemnum;
END;
/
/

-- Name: insert_invoice; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.insert_invoice(p_invnum character, p_empnum character, p_onum character, p_time timestamp without time zone, p_transportation character varying)
AS  DECLARE 
BEGIN
    -- 插入新的发货单记录
    INSERT INTO invoice (invnum, empnum, onum, time, transportation)
    VALUES (p_invnum, p_empnum, p_onum, p_time, p_transportation);

EXCEPTION
    -- 捕获并处理可能的异常情况
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION '员工编号或订单编号不存在.';
    WHEN unique_violation THEN
        RAISE EXCEPTION '发货单的主键 (empnum, onum) 已经存在.';
END;
/
/

-- Name: recalculate_order_total; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.recalculate_order_total()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    total_price DECIMAL := 0;
BEGIN
    -- 计算订单的总价（包括折扣）
    SELECT COALESCE(SUM(discamount), 0) INTO total_price
    FROM "ApplyDisc"
    WHERE Onum = OLD.Onum;

    -- 更新订单表中的总价字段
    UPDATE "Order" SET Totalprice = total_price WHERE Onum = OLD.Onum;

    RETURN NULL;
END;
$$;
/

-- Name: recalculate_order_total; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.recalculate_order_total(order_id character)
 RETURNS void
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    total_price DECIMAL := 0;
BEGIN
    -- 计算订单的总价（包括折扣）
    SELECT COALESCE(SUM(discamount), 0) INTO total_price
    FROM "ApplyDisc"
    WHERE Onum = order_id;

    -- 更新订单表中的总价字段
    UPDATE "Order" SET Totalprice = total_price WHERE Onum = order_id;
END;
$$;
/

-- Name: to_chinese_month; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.to_chinese_month(month_num integer)
 RETURNS text
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
BEGIN
    CASE month_num
        WHEN 1 THEN RETURN '1月';
        WHEN 2 THEN RETURN '2月';
        WHEN 3 THEN RETURN '3月';
        WHEN 4 THEN RETURN '4月';
        WHEN 5 THEN RETURN '5月';
        WHEN 6 THEN RETURN '6月';
        WHEN 7 THEN RETURN '7月';
        WHEN 8 THEN RETURN '8月';
        WHEN 9 THEN RETURN '9月';
        WHEN 10 THEN RETURN '10月';
        WHEN 11 THEN RETURN '11月';
        WHEN 12 THEN RETURN '12月';
        ELSE RETURN '未知';
    END CASE;
END;
$$;
/

-- Name: update_inventory_and_totalprice; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.update_inventory_and_totalprice()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE 
    available_quantity INTEGER;
    flower_price INTEGER;
BEGIN
    -- 检查插入的供应数量是否为负数
    IF NEW.Bundlenumber < 0 THEN
        RAISE EXCEPTION '供应数量不能为负数。';
    END IF;

    -- 查询鲜花库存数量
    SELECT number INTO available_quantity
    FROM Flower
    WHERE Flonum = NEW.Flonum;

    -- 检查库存是否足够
    IF available_quantity < NEW.Bundlenumber THEN
        RAISE EXCEPTION '库存不足，无法完成供应。';
    ELSE
        -- 更新鲜花库存数量
        UPDATE Flower
        SET Number = Number - NEW.Bundlenumber
        WHERE Flonum = NEW.Flonum;
    		-- 获取鲜花单价
        SELECT Price INTO flower_price
        FROM Flower
        WHERE Flonum = NEW.Flonum;
    
        -- 计算供应总价
        NEW.totalprice := NEW.Bundlenumber * flower_price;
        RETURN NEW;
    END IF;
END;
$$;
/

-- Name: update_item_price; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE PROCEDURE liuhongkun.update_item_price(price_change_rate double precision)
AS 
DECLARE
    is_valid_input BOOLEAN;
BEGIN
    -- 检查输入参数是否合法
    IF price_change_rate > 1 OR price_change_rate < -1 THEN
        RAISE EXCEPTION '价格变动率必须在 -1 到 1 之间.';
    ELSE
        is_valid_input := TRUE;
    END IF;

    -- 如果输入参数合法，则进行价格修改操作
    IF is_valid_input THEN
        -- 使用游标遍历商品表
        FOR item_record IN 
            SELECT * FROM item
        LOOP
            -- 对每个商品的价格进行更新
            UPDATE item
            SET price = price * (1 + price_change_rate)
            WHERE itemnum = item_record.itemnum;

            -- 提示信息
            IF price_change_rate > 0 THEN
                RAISE NOTICE '已将商品 % 的价格上涨.', item_record.itemnum;
            ELSE
                RAISE NOTICE '已将商品 % 的价格下跌.', item_record.itemnum;
            END IF;
        END LOOP;

        -- 提示信息
        RAISE NOTICE '已更新所有商品的价格.';
    END IF;
END;
/
/

-- Name: update_item_stock_on_payment; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.update_item_stock_on_payment()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    order_rec RECORD;
BEGIN
    -- 检查支付状态是否为 "是"
    IF NEW.paystate = '是' THEN
        -- 遍历与订单相关的应用折扣表记录
        FOR order_rec IN
            SELECT Itemnum, Number
            FROM "ApplyDisc"
            WHERE Onum = NEW.Onum
        LOOP
            -- 更新商品表中的库存数量
            UPDATE Item
            SET Number = Number - order_rec.Number
            WHERE Itemnum = order_rec.Itemnum;

            -- 检查库存数量是否为非负数
            IF (SELECT Number FROM Item WHERE Itemnum = order_rec.Itemnum) < 0 THEN
                RAISE EXCEPTION '商品 % 的库存数量不足.', order_rec.Itemnum;
            END IF;
        END LOOP;
    END IF;

    RETURN NEW;
END;
$$;
/

-- Name: update_order_total_price; Type: Function; Schema: liuhongkun;

CREATE OR REPLACE FUNCTION liuhongkun.update_order_total_price()
 RETURNS trigger
 LANGUAGE plpgsql
 NOT FENCED NOT SHIPPABLE
AS $$
DECLARE
    total_price DECIMAL := 0;
BEGIN
    -- 计算订单的总价（包括折扣）
    SELECT SUM(discamount) INTO total_price
    FROM "ApplyDisc"
    WHERE Onum = NEW.Onum;

    -- 检查订单总价是否为非负值
    IF total_price < 0 THEN
        RAISE EXCEPTION '订单总价不能为负数.';
END IF;

	-- 保留两位小数
total_price := ROUND(total_price, 2);

    -- 更新订单表中的总价字段
    UPDATE "Order"
    SET Totalprice = total_price
    WHERE Onum = NEW.Onum;

    RETURN NEW;
END;
$$;
/

-- Name: ApplyDisc; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE "ApplyDisc" (
	onum character(6) NOT NULL,
	itemnum character(7) NOT NULL,
	"number" integer NOT NULL,
	discnum character(3),
	discamount double precision,
    CONSTRAINT fk_orderdisc_order FOREIGN KEY (onum) REFERENCES "Order"(onum) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_order_item FOREIGN KEY (itemnum) REFERENCES item(itemnum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
ALTER TABLE "ApplyDisc" ADD CONSTRAINT pk_orderdiscount PRIMARY KEY (onum, itemnum);
CREATE INDEX fk_orderdisc_order ON "ApplyDisc" USING btree (discnum) TABLESPACE pg_default;
CREATE INDEX fk_order_item ON "ApplyDisc" USING btree (itemnum) TABLESPACE pg_default;

-- Name: ApplyDisc; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE "ApplyDisc" FROM PUBLIC;
 REVOKE ALL ON TABLE "ApplyDisc" FROM liuhongkun;
GRANT ALL ON TABLE "ApplyDisc" TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "ApplyDisc" TO cx;


--Data for  Name: ApplyDisc; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000111','1000001',2,'005',272.800000000000011);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000111','1000008',1,'001',95.8320000000000078);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000111','1000002',1,'001',296.010000000000048);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000006','1000005',1,'005',783.200000000000159);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000008','1000001',2,'005',272.800000000000011);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000010','1000010',1,'001',450.450000000000045);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000005','1000006',1,'005',323.840000000000032);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000004','1000004',1,'005',465.520000000000095);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000010','1000004',2,'001',1047.4200000000003);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000007','1000008',4,'005',348.480000000000018);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000002','1000002',1,'005',263.120000000000061);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000003','1000003',1,'005',227.920000000000044);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000006','1000007',3,'005',208.560000000000059);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000009','1000009',1,'001',335.610000000000014);
INSERT INTO liuhongkun."ApplyDisc" (onum,itemnum,number,discnum,discamount)
 VALUES ('000001','1000001',1,'001',153.450000000000017);


-- Name: Order; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE "Order" (
	onum character(6) NOT NULL,
	custnum character(7) NOT NULL,
	selnum character(5) NOT NULL,
	ordertime timestamp(0) without time zone DEFAULT pg_systimestamp() NOT NULL,
	paystate character varying(10) DEFAULT '否'::character varying,
	totalprice double precision,
	paytime timestamp without time zone,
    CONSTRAINT fk_order_customer FOREIGN KEY (custnum) REFERENCES customer(custnum) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_order_seller FOREIGN KEY (selnum) REFERENCES seller(selnum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
CREATE INDEX check_fk ON "Order" USING btree (selnum) TABLESPACE pg_default;
CREATE INDEX buy_fk ON "Order" USING btree (custnum) TABLESPACE pg_default;
ALTER TABLE "Order" ADD CONSTRAINT pk_order PRIMARY KEY (onum);

-- Name: Order; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE "Order" FROM PUBLIC;
 REVOKE ALL ON TABLE "Order" FROM liuhongkun;
GRANT ALL ON TABLE "Order" TO liuhongkun;
GRANT ALL ON TABLE "Order" TO sales_staff;
GRANT SELECT ON TABLE "Order" TO customer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Order" TO cx;


--Data for  Name: Order; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000111','2000010','00005','2024-06-07 14:22:40','是',664.639999999999986,null);
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000008','2000008','00004','2024-05-01 15:48:47','是',272.800000000000011,'2024-05-01 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000005','2000005','00003','2024-04-01 15:48:47','是',323.839999999999975,'2024-04-01 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000004','2000004','00002','2024-03-27 15:48:47','是',465.519999999999982,'2024-03-27 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000010','2000006','00003','2024-06-01 15:48:47','是',1497.86999999999989,'2024-06-01 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000007','2000007','00004','2024-04-16 15:48:47','是',348.480000000000018,'2024-04-16 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000002','2000002','00001','2024-02-20 15:48:47','是',263.120000000000005,'2024-02-20 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000003','2000003','00002','2024-03-21 15:48:47','是',227.919999999999987,'2024-03-21 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000006','2000006','00003','2024-04-11 15:48:47','是',991.759999999999991,'2024-04-11 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000009','2000002','00005','2024-05-31 15:48:47','是',335.610000000000014,'2024-05-31 15:50:47');
INSERT INTO liuhongkun."Order" (onum,custnum,selnum,ordertime,paystate,totalprice,paytime)
 VALUES ('000001','2000001','00001','2024-01-10 15:48:47','是',153.449999999999989,'2024-01-10 15:50:47');


-- Name: customer; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE customer (
	custnum character(7) NOT NULL,
	custname character varying(20) NOT NULL,
	receiveraddress character varying(100),
	contactnumber character(11),
	password character varying(30) DEFAULT 'cust@123456'::character varying NOT NULL,
	email character varying(20),
	member character varying(10) DEFAULT '否'::character varying NOT NULL,
	registerdate timestamp without time zone DEFAULT text_date('now'::text) NOT NULL
)
WITH (orientation=row, compression=no);
ALTER TABLE customer ADD CONSTRAINT pk_customer PRIMARY KEY (custnum);

-- Name: customer; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE customer FROM PUBLIC;
 REVOKE ALL ON TABLE customer FROM liuhongkun;
GRANT ALL ON TABLE customer TO liuhongkun;
GRANT SELECT ON TABLE customer TO customer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE customer TO cx;
GRANT ALL ON TABLE customer TO chenxu;


--Data for  Name: customer; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000003','邰子石','南京','1542223333 ','cust@123456','yzs@qq.com','是','2023-03-01 14:10:55');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000004','芮博延','成都','1583334444 ','cust@123456','bby@qq.com','否','2024-01-12 14:11:04');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000010','巢庆','昆明','1589630200 ','cust@123456','cq@qq.com','否','2024-01-02 14:11:10');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000005','甘玉宇','济南','1583288424 ','cust@123456','gyy@123.com','是','2023-12-21 14:11:16');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000007','苍仁','长沙','1936667778 ','cust@123456','cr@hdu.com','是','2023-11-11 14:11:20');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000008','邓政','石家庄','153773688  ','cust@123456','dz@hdu.com','否','2023-09-09 14:11:25');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000009','孟宙','西安','1578833859 ','cust@123456','mz@qq.com','是','2024-03-03 14:11:31');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000002','杜敏学','杭州','1532457214 ','cust@123456','dmx@qq.com','是','2024-01-02 14:11:36');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000006','马乐生','郑州','1935534666 ','cust@123456','mls@123.com','是','2024-03-21 14:11:41');
INSERT INTO liuhongkun.customer (custnum,custname,receiveraddress,contactnumber,password,email,member,registerdate)
 VALUES ('2000001','相嘉佑','广州','1539378780 ','cust@123456','xjy@qq.com','否','2023-12-30 14:11:51');


-- Name: department; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE department (
	deptnum character(4) NOT NULL,
	deptname character varying(20) NOT NULL,
	chargername character varying(20),
	contactnumber character varying(11),
	deptintro character varying(400),
	createdate timestamp without time zone DEFAULT text_date('now'::text) NOT NULL
)
WITH (orientation=row, compression=no);
ALTER TABLE department ADD CONSTRAINT pk_department PRIMARY KEY (deptnum);

-- Name: department; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE department FROM PUBLIC;
 REVOKE ALL ON TABLE department FROM liuhongkun;
GRANT ALL ON TABLE department TO liuhongkun;
GRANT ALL ON TABLE department TO d_header;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE department TO cx;


--Data for  Name: department; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0004','物流部','张碧昭','12434934891','物流部负责订单的打包和配送，管理仓储和库存，确保花材和相关物资的安全存储与及时发货。通过高效的运输安排和跟踪系统，我们致力于为客户提供快捷、可靠的配送服务，确保每一束花都能准时、完好地送达。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0005','财务部','江晓婷','15328946284','财务部负责管理公司的财务记录和报表，确保所有交易的准确记录和透明性。主要职能包括预算编制、成本控制、资金管理、税务申报和财务分析。通过精细的财务管理和严格的财务审核，财务部为公司的可持续发展提供坚实的财务支持。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0006','客服部','杜瑞峰','19848530822','我们的客服部致力于为每一位客户提供优质的服务和支持。无论您有任何问题、意见或建议，我们的专业团队都会以热情和耐心为您解答，确保您的购物体验顺畅愉快。我们始终以客户满意为中心，竭诚为您提供周到的售前、售中及售后服务，让您感受到我们的贴心关怀。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0007','技术部','吴培文','13559794293','技术部负责公司网站和系统的开发与维护，确保平台的安全、稳定和高效运行。该部门处理技术故障，优化用户体验，保障系统的持续更新与升级，支持其他部门的技术需求，推动公司整体业务的发展。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0008','人力资源部','胡津赞','18803984361','人力资源部负责公司的人才管理和发展，致力于招聘和培训优秀员工，管理员工关系和福利，确保员工的职业发展和满意度。我们通过绩效评估和职业规划，推动员工与公司的共同成长，为公司的长远发展提供坚实的人才支持。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0009','设计部','谭英娟','13899472119','设计部是我们网上鲜花销售系统中的创意中心，负责精心设计花束和包装方案，为客户带来独特的视觉体验和美好的购物感受。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0002','市场部','朱圣桢','17423941039','市场部负责品牌推广和市场宣传，进行市场调研和分析，设计并执行广告和促销活动，旨在提升品牌知名度和市场占有率，吸引更多客户，推动公司销售增长和业务发展。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0001','销售部','冯敬威','16654938482','销售部是公司与客户沟通的桥梁，致力于提供卓越的客户服务和高效的订单处理。我们负责管理客户关系、跟进销售动态、制定销售策略，并通过多样化的促销活动提升品牌影响力。销售团队始终秉持着客户至上的理念，确保每一位客户都能享受到优质的购物体验和满意的售后服务。','2022-06-01 00:00:00');
INSERT INTO liuhongkun.department (deptnum,deptname,chargername,contactnumber,deptintro,createdate)
 VALUES ('0003','采购部','谢泽运','15439195832','采购部负责公司所有花材和相关物资的采购工作，确保库存充足、质量上乘。我们与各大优质供应商建立了长期稳定的合作关系，严格把控采购流程，从源头上保障产品的高品质和新鲜度，为客户提供最优质的鲜花产品。','2022-06-01 00:00:00');


-- Name: discount; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE discount (
	discnum character(3) NOT NULL,
	discname character varying(40) NOT NULL,
	class character varying(20),
	discvalue double precision,
	info character varying(300)
)
WITH (orientation=row, compression=no);
ALTER TABLE discount ADD CONSTRAINT pk_discount PRIMARY KEY (discnum);

-- Name: discount; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE discount FROM PUBLIC;
 REVOKE ALL ON TABLE discount FROM liuhongkun;
GRANT ALL ON TABLE discount TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE discount TO cx;


--Data for  Name: discount; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('002','清明节折扣','节日',.849999999999999978,'清明节前一周到清明节结束，所有菊花打八五折折扣');
INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('003','情人节折扣','节日',.800000000000000044,'情人节期间所有玫瑰花享有八折折扣');
INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('005','新客户折扣','顾客',.800000000000000044,'新客户首次下单享有全场商品八折折扣');
INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('004','FLOWER优惠券折扣','优惠券',20,'使用“FLOWER20230601优惠码”可以享有满100减20元折扣，不能和其他折扣叠加');
INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('006','老客户折扣','顾客',.900000000000000022,'注册满一年的客户享受九折折扣');
INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('000','原价','不打折',1,'不使用任何折扣，按原价计算');
INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('007','满减折扣1','满减',20,'满300优惠20元');
INSERT INTO liuhongkun.discount (discnum,discname,class,discvalue,info)
 VALUES ('001','会员折扣','顾客',.900000000000000022,'爱情类商品九折，亲情类和友情类商品八七折，生日类、周年纪念和祝福类商品八八折，其他类商品九五折，注册为会员的用户永久享有该折扣，优先级最低');


-- Name: employee; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE employee (
	empnum character(7) NOT NULL,
	empname character varying(20) NOT NULL,
	deptnum character(4),
	contactnumber character varying(11),
	entrydate timestamp(0) without time zone,
	birth timestamp(0) without time zone,
	address character varying(100),
	password character varying(30) DEFAULT 'emp@123456'::character varying NOT NULL,
	email character varying(20),
	salary integer,
    CONSTRAINT chk_emp_entry CHECK (((deptnum IS NOT NULL) OR (entrydate IS NULL))),
    CONSTRAINT fk_employee_belongto_departme FOREIGN KEY (deptnum) REFERENCES department(deptnum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
CREATE INDEX belongto_fk ON employee USING btree (deptnum) TABLESPACE pg_default;
ALTER TABLE employee ADD CONSTRAINT pk_employee PRIMARY KEY (empnum);

-- Name: employee; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE employee FROM PUBLIC;
 REVOKE ALL ON TABLE employee FROM liuhongkun;
GRANT ALL ON TABLE employee TO liuhongkun;
GRANT ALL ON TABLE employee TO d_header;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE employee TO cx;


--Data for  Name: employee; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000012','顾成涛','0006','18320183016','2022-06-01 00:00:00','1995-05-31 00:00:00','上海市浦东新区陆家嘴环路66号','emp@123456','gbtpmo@outlook.com',6500);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000013','林文燕','0006','18920189010','2022-06-01 00:00:00','1994-03-07 00:00:00','江苏省南京市鼓楼区中山北路98号','emp@123456','exufrg@qq.com',6000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000014','傅红雪','0007','13720137002','2022-06-01 00:00:00','1996-02-14 00:00:00','四川省成都市锦江区红星路一段88号','emp@123456','zqtkol@zoho.com',12000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000015','丁泽中','0007','15110151028','2022-06-01 00:00:00','1993-12-21 00:00:00','山东省济南市历下区泉城路123号','emp@123456','ibwcut@outlook.com',9000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000017','方思月','0008','18410184015','2022-06-01 00:00:00','1994-04-13 00:00:00','河南省郑州市金水区花园路56号','emp@123456','vrkfua@outlook.com',8700);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000018','谢明轩','0009','18810188011','2022-06-01 00:00:00','1999-07-14 00:00:00','陕西省西安市碑林区长安南路18号','emp@123456','umqpvn@qq.com',8900);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000004','田争黎','0002','11816454678','2022-06-01 00:00:00','1998-11-23 00:00:00','上海市浦东新区世纪大道456号','emp@123456','qdnjso@zoho.com',7500);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000005','邢纪秦','0003','16513135778','2022-06-01 00:00:00','1997-04-02 00:00:00','江苏省南京市玄武区中山路789号','emp@123456','mlvnsz@outlook.com',8300);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000006','范玉岭','0003','18755345558','2022-06-01 00:00:00','1996-01-03 00:00:00','四川省成都市武侯区人民南路101号','emp@123456','adwzml@qq.com',8900);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000007','余美凤','0003','13030130009','2022-06-01 00:00:00','2002-07-14 00:00:00','山东省济南市历下区泉城路202号','emp@123456','rqdnwk@qq.com',9100);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000019','滕小松','0009','15600156023','2022-06-01 00:00:00','2002-06-25 00:00:00','浙江省杭州市钱塘区文泽路52号','emp@123456','jndcpo@outlook.com',10000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000020','冯云山','0001','18100181018','2022-06-01 00:00:00','2000-11-20 00:00:00','湖南省长沙市天心区芙蓉中路120号','emp@123456','bmrzgw@outlook.com',10000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000016','杨志远','0008','18110181018','2022-06-01 00:00:00','2002-09-24 00:00:00','湖南省长沙市岳麓区桐梓坡路200号','emp@123456','kdloiq@zoho.com',8200);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000001','任亮逊','0001','13812345678','2022-06-01 00:00:00','2002-05-20 00:00:00','浙江省杭州市西湖区文三路88号','emp@123456','vpqslz@qq.com',8000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000002','叶准崇','0001','13765645678','2022-06-01 00:00:00','2001-12-01 00:00:00','广东省广州市天河区体育西路123号','emp@123456','zndkio@outlook.com',9000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000003','松榕蔚','0002','13812341321','2022-06-01 00:00:00','2001-03-12 00:00:00','北京市朝阳区朝阳北路123号','emp@123456','jhncxz@qq.com',8500);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000008','郭文洋','0004','13230132007','2022-06-01 00:00:00','2001-08-15 00:00:00','湖南省长沙市天心区芙蓉路303号','emp@123456','xvlqik@outlook.com',7300);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000009','范小冰','0004','15020150029','2022-06-01 00:00:00','2002-10-26 00:00:00','河南省郑州市金水区花园路505号','emp@123456','fiyrha@outlook.com',7000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000010','徐哲','0005','15620156023','2022-06-01 00:00:00','2002-10-27 00:00:00','陕西省西安市雁塔区长安路404号','emp@123456','epvnzq@qq.com',9900);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000011','林家荣','0005','15820158021','2022-06-01 00:00:00','2000-06-30 00:00:00','北京市朝阳区建国路12号','emp@123456','nqzlbv@zoho.com',11000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000100','胡飞扬','0001',null,'2022-01-01 00:00:00',null,null,'emp@123456',null,6000);
INSERT INTO liuhongkun.employee (empnum,empname,deptnum,contactnumber,entrydate,birth,address,password,email,salary)
 VALUES ('3000023','张三','0001','12345678901','2024-06-06 00:00:00','1990-01-01 00:00:00','某某街道','emp@123456','zhangsan@example.com',5000);


-- Name: evaluate; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE evaluate (
	onum character(6) NOT NULL,
	empnum character(7),
	evalcontent character varying(500),
	empreply character varying(500),
	evaltime timestamp without time zone,
	replytime timestamp without time zone,
	itemnum character(7) NOT NULL,
    CONSTRAINT fk_item_evaluate FOREIGN KEY (itemnum) REFERENCES item(itemnum) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_evaluate_order FOREIGN KEY (onum) REFERENCES "Order"(onum) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_employee_evaluate FOREIGN KEY (empnum) REFERENCES employee(empnum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
CREATE INDEX evaluate_item_fk ON evaluate USING btree (itemnum) TABLESPACE pg_default;
ALTER TABLE evaluate ADD CONSTRAINT pk_evaluate PRIMARY KEY (onum, itemnum);
CREATE INDEX idx_evaluate_empnum ON evaluate USING btree (empnum) TABLESPACE pg_default;
CREATE INDEX evaluate_order_fk ON evaluate USING btree (onum) TABLESPACE pg_default;

-- Name: evaluate; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE evaluate FROM PUBLIC;
 REVOKE ALL ON TABLE evaluate FROM liuhongkun;
GRANT ALL ON TABLE evaluate TO liuhongkun;
GRANT ALL ON TABLE evaluate TO cs_staff;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE evaluate TO cx;


--Data for  Name: evaluate; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000003','3000012','白色和浅蓝色的包装纸层层包裹着花束，再用蓝白相间的丝带扎束，非常高雅和精致。','如果您以后有任何花卉需求或建议，请随时与我们联系。我们期待再次为您服务，并希望每一次购物都能为您带来同样的满意和喜悦。','2024-03-23 15:41:49','2024-03-23 15:44:21','1000003');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000005','3000013','送给朋友的生日礼物，她非常开心和感动。感谢商家用心的设计和高品质的花材，真的是一次非常愉快的购物体验！','非常感谢您的好评！我们很高兴听到您和您的朋友对这束黄玫瑰花束如此满意。我们一直致力于提供新鲜高品质的花材和精美的包装设计，您的认可是我们最大的动力。','2024-04-03 15:41:49','2024-04-03 15:44:21','1000006');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000009','3000013','第二次买花！我非常喜欢这束粉色康乃馨，配上石竹梅、紫色勿忘我和绿叶，色彩搭配非常和谐，整束花朵看起来十分精致。','我们一直致力于为顾客提供高质量的花艺产品和优质的服务，希望我们的花束能为您带来更多的快乐和美好的回忆。期待您的下次光临！','2024-06-02 15:41:49','2024-06-02 15:44:21','1000009');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000007','3000013','向日葵的花朵鲜艳，花瓣完整，看起来非常新鲜。包装也很用心，用英文报纸和透明纸包裹，再用拉菲草扎束，显得既时尚又优雅。',null,'2024-04-19 15:41:49',null,'1000008');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000004','3000012','感谢商家提供这么漂亮的花束，包装得非常用心，花朵也很新鲜。强烈推荐给大家！',null,'2024-03-29 15:41:49',null,'1000004');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000001','3000012','这个花束无论是用来表达爱意，还是作为礼物送给朋友，都是一个非常不错的选择。非常感谢卖家的用心设计和精细包装，以后还会再来购买的！','希望这束美丽的花能为您带来快乐和美好的回忆。我们也期待在未来继续为您提供更多优质的花卉产品。如果您有任何建议或需要帮助，请随时与我们联系，我们将竭诚为您服务。','2024-01-12 15:41:49','2024-07-01 10:00:00','1000001');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000010','3000013','这是我第二次来买花了，美丽的紫色郁金香，搭配绿叶和蛇鞭菊，再加上透明玻璃纸和白色雪点网纱的内衬，整体包装非常精美。','感谢您对我们的支持和肯定，我们一直致力于为顾客提供高品质的花束和完善的服务。希望我们的产品能为您带来愉快的购物体验，期待您的再次光临！','2024-06-03 15:41:49','2024-06-03 15:44:21','1000004');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000002','3000012','这束花的整体搭配非常精美。玫瑰鲜艳欲滴，绿叶的点缀让整束花显得格外生机勃勃。内衬的黄色绵纸和外层粉色卷边纸的搭配，非常有层次感，再加上粉色丝带的扎束，整个包装显得格外精致高雅。','您的支持和认可是我们不断进步的源泉。我们将继续努力，为您提供更多优质的花卉和更加贴心的服务。期待您下次光临，并祝您生活愉快，天天都有好心情！','2024-02-22 15:41:49','2024-02-22 15:44:21','1000002');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000006','3000012','我为母亲的生日订购了这款紫玫瑰花束，她非常喜欢。我的朋友收到了我送的这款白色百合花束，她非常开心。','我们的设计团队致力于用心打造每一束花，希望能在每一个特别的日子为您和您的亲友带来美好的回忆。期待在未来的日子里','2024-04-13 15:41:49','2024-04-13 15:44:21','1000005');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000008','3000013','这束花收到后就像一幅精美的画，给人一种愉悦和温暖的感觉。非常感谢商家的精心制作和快递的及时送达！','我们一直致力于为顾客提供高品质的花束和周到的服务，您的满意是我们最大的动力。期待您的再次光临，祝您生活愉快！','2024-05-03 15:41:49','2024-05-03 15:44:21','1000001');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000111',null,'这是一个很好的产品',null,'2024-06-07 00:00:00',null,'1000001');
INSERT INTO liuhongkun.evaluate (onum,empnum,evalcontent,empreply,evaltime,replytime,itemnum)
 VALUES ('000111',null,'这是一个很好的产品',null,'2024-06-07 00:00:00',null,'1000008');


-- Name: flower; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE flower (
	flonum character(7) NOT NULL,
	floname character varying(20) NOT NULL,
	color character varying(20),
	unit character varying(20),
	price integer,
	warenum character(4),
	"number" integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_flo_price CHECK ((price > 0)),
    CONSTRAINT fk_flower_save_warehous FOREIGN KEY (warenum) REFERENCES warehouse(warenum)
)
WITH (orientation=row, compression=no);
CREATE INDEX save_fk ON flower USING btree (warenum) TABLESPACE pg_default;
ALTER TABLE flower ADD CONSTRAINT pk_flower PRIMARY KEY (flonum);

-- Name: flower; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE flower FROM PUBLIC;
 REVOKE ALL ON TABLE flower FROM liuhongkun;
GRANT ALL ON TABLE flower TO liuhongkun;
GRANT ALL ON TABLE flower TO supplier;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE flower TO cx;
GRANT ALL ON TABLE flower TO chenxu;


--Data for  Name: flower; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000001','卡罗拉','红色','20枝/扎',16,'0001',20);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0001000','秋海棠','黄色','20扎/捆',19,'0010',20);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0001001','五月花','红色','20扎/捆',18,'0010',16);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000002','黑魔术','黑红色','20枝/扎',15,'0001',30);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000003','影星','粉色','20枝/扎',18,'0001',40);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000004','戴安娜','粉色','20枝/扎',19,'0001',50);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000005','坦尼克','白色','20枝/扎',17,'0001',40);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000006','雪山','白色','20枝/扎',18,'0002',30);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000007','蓝色妖姬','蓝色','20枝/扎',19,'0002',20);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000008','金枝玉叶','黄色','20枝/扎',18,'0002',25);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000009','海洋之歌','淡紫色','20枝/扎',17,'0002',35);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000010','紫霞仙子','浅紫色','20枝/扎',20,'0002',45);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000011','泰姬','紫红色','20枝/扎',16,'0003',55);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000012','紫皇后','紫色','20枝/扎',18,'0003',65);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000013','冷美人','紫色','20枝/扎',19,'0003',55);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000014','荔枝','粉色','20枝/扎',22,'0003',35);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000015','金香玉','黄色','20枝/扎',17,'0003',34);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000016','大桃红','桃红色','20枝/扎',15,'0004',33);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000017','芬得拉','乳白色','20枝/扎',18,'0004',32);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000018','玛利亚','杏红色','20枝/扎',19,'0004',31);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000019','假日公主','橙黄色','20枝/扎',22,'0004',30);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000020','皇冠','黄色','20枝/扎',16,'0004',26);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000021','白百合','白色','20枝/扎',14,'0005',27);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000022','向日葵','黄色','20枝/扎',17,'0006',28);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000024','紫色郁金香','紫色','20枝/扎',21,'0008',21);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000025','富贵竹','绿色','10枝/扎',12,'0009',9);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000023','单头康乃馨','各色','20枝/扎',18,'0007',29);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000026','紫罗兰','各色','10枝/扎',10,'0010',6);
INSERT INTO liuhongkun.flower (flonum,floname,color,unit,price,warenum,number)
 VALUES ('0000099','香水','红色','20枝/扎',10,'0001',100);


-- Name: invoice; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE invoice (
	invnum character(10) NOT NULL,
	empnum character(7) NOT NULL,
	onum character(6) NOT NULL,
	"time" timestamp without time zone,
	transportation character varying(10),
    CONSTRAINT fk_invoice_order FOREIGN KEY (onum) REFERENCES "Order"(onum) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_invoice_employeep_employee FOREIGN KEY (empnum) REFERENCES employee(empnum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
CREATE INDEX employeeprocess_fk ON invoice USING btree (empnum) TABLESPACE pg_default;
CREATE INDEX processorder_fk ON invoice USING btree (onum) TABLESPACE pg_default;
ALTER TABLE invoice ADD CONSTRAINT pk_invoice PRIMARY KEY (empnum, onum);

-- Name: invoice; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE invoice FROM PUBLIC;
 REVOKE ALL ON TABLE invoice FROM liuhongkun;
GRANT ALL ON TABLE invoice TO liuhongkun;
GRANT ALL ON TABLE invoice TO logistics_staff;
GRANT ALL ON TABLE invoice TO seller;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE invoice TO cx;


--Data for  Name: invoice; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('7347634822','3000008','000002','2024-02-20 16:00:00','空运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('9743974292','3000008','000003','2024-03-21 16:00:00','空运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('9328328283','3000009','000005','2024-04-01 16:00:00','陆运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('1328939218','3000008','000006','2024-04-11 16:00:00','陆运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('2918721362','3000009','000007','2024-04-16 16:00:00','陆运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('1937712981','3000009','000008','2024-05-01 16:00:00','陆运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('5387248731','3000009','000009','2024-05-31 16:00:00','空运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('5637738723','3000009','000010','2024-06-01 16:00:00','空运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('9475387722','3000008','000004','2024-03-27 16:00:00','空运');
INSERT INTO liuhongkun.invoice (invnum,empnum,onum,time,transportation)
 VALUES ('4723179311','3000008','000001','2024-01-14 00:00:00','空运');


-- Name: item; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE item (
	itemnum character(7) NOT NULL,
	itemname character varying(20) NOT NULL,
	price double precision,
	"number" integer DEFAULT 0 NOT NULL,
	class character varying(20),
	intro character varying(200),
	flonum character(7) NOT NULL,
    CONSTRAINT chk_item_price CHECK ((price > (0)::double precision)),
    CONSTRAINT fk_item_packflowe_flower FOREIGN KEY (flonum) REFERENCES flower(flonum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
CREATE INDEX packflower_fk ON item USING btree (flonum) TABLESPACE pg_default;
ALTER TABLE item ADD CONSTRAINT pk_item PRIMARY KEY (itemnum);

-- Name: item; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE item FROM PUBLIC;
 REVOKE ALL ON TABLE item FROM liuhongkun;
GRANT ALL ON TABLE item TO liuhongkun;
GRANT ALL ON TABLE item TO seller;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE item TO cx;
GRANT ALL ON TABLE item TO chenxu;


--Data for  Name: item; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000001','卡罗拉之约',170.5,10,'爱情','10朵红玫瑰+满天星+黄莺点缀.内衬白色棉纸,外围红色皱纹纸,粉色棉纸束腰,粉色丝带搭配','0000001');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000008','向阳而生',108.900000000000006,17,'祝福','单只向日葵,英文报纸、透明纸精美包装,拉菲草扎束','0000022');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000002','淡粉华年',328.900000000000034,7,'爱情','昆明A级戴安娜19朵玫瑰，绿叶搭配，黄色绵纸内衬，粉色卷边纸多层精美包装，粉色丝带扎束','0000004');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000003','海岸浪花',284.900000000000034,8,'爱情','12朵白玫瑰，绣球、绿叶搭配。白色，浅蓝色包装纸多层包装，蓝白相间丝带扎束','0000005');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000004','紫气东来',581.900000000000091,7,'爱情','21朵紫玫瑰，2枝多头香水百合，绿叶适量搭配，紫色包装纸包装，白色纱网包围，紫色丝带扎束','0000012');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000006','馥郁芬芳',404.800000000000011,5,'周年纪念','11朵黄玫瑰,尤加利间插,适量芒叶搭配,红色皱纹纸扇形包装，红色丝带扎束,韩式花束精美包装','0000015');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000007','童话世界',86.9000000000000057,15,'生日','单枝多头白色百合，搭配芒叶、满天星，白色手揉纸，绿色硬纱圆形包装，绿色丝带扎束','0000021');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000005','星落紫鸾',979.000000000000114,3,'友情','66朵紫玫瑰，配满天星、黄莺点缀，紫色羽毛外围、紫色纱网精美包装；紫色丝带扎束','0000013');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000009','福乐绵绵',372.900000000000034,16,'亲情','粉色康乃馨21朵，配石竹梅，紫色勿忘我，绿叶，白色卷边纸内衬，粉色卷边纸外围，紫色法式蝴蝶结束扎','0000023');
INSERT INTO liuhongkun.item (itemnum,itemname,price,number,class,intro,flonum)
 VALUES ('1000010','紫影迷梦',500.500000000000057,3,'爱情','11朵紫色郁金香,搭配绿叶、蛇鞭菊适量,透明玻璃纸、白色雪点网纱内衬,紫色手揉纸多层扇形包装,白色带花丝带扎束','0000024');


-- Name: provide; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE provide (
	flonum character(7) NOT NULL,
	"time" timestamp(0) without time zone DEFAULT pg_systimestamp() NOT NULL,
	totalprice double precision NOT NULL,
	bundlenumber integer NOT NULL,
	supnum character(6) NOT NULL,
	selnum character(5) NOT NULL,
    CONSTRAINT fk_provide_flower FOREIGN KEY (flonum) REFERENCES flower(flonum) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_seller_provide FOREIGN KEY (selnum) REFERENCES seller(selnum) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_supplier_provide FOREIGN KEY (supnum) REFERENCES supplier(supnum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
CREATE INDEX supplier_provide_fk ON provide USING btree (supnum) TABLESPACE pg_default;
ALTER TABLE provide ADD CONSTRAINT pk_provide PRIMARY KEY (flonum, supnum, selnum);
CREATE INDEX provide_to_seller_fk ON provide USING btree (selnum) TABLESPACE pg_default;
CREATE INDEX provide_flower_fk ON provide USING btree (flonum) TABLESPACE pg_default;

-- Name: provide; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE provide FROM PUBLIC;
 REVOKE ALL ON TABLE provide FROM liuhongkun;
GRANT ALL ON TABLE provide TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE provide TO cx;


--Data for  Name: provide; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000011','2024-05-27 00:00:00',320,20,'000001','00001');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000002','2024-05-27 00:00:00',150,10,'000002','00002');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000012','2024-05-27 00:00:00',360,20,'000002','00002');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000003','2024-05-27 00:00:00',180,10,'000003','00003');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000013','2024-05-27 00:00:00',380,20,'000003','00003');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000004','2024-05-27 00:00:00',190,10,'000004','00004');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000014','2024-05-27 00:00:00',440,20,'000004','00004');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000005','2024-05-27 00:00:00',170,10,'000005','00005');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000006','2024-05-27 00:00:00',180,10,'000006','00006');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000016','2024-05-27 00:00:00',300,20,'000006','00006');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000007','2024-05-27 00:00:00',190,10,'000007','00007');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000017','2024-05-27 00:00:00',360,20,'000007','00007');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000008','2024-05-27 00:00:00',180,10,'000008','00008');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000018','2024-05-27 00:00:00',380,20,'000008','00008');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000009','2024-05-27 00:00:00',170,10,'000009','00009');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000019','2024-05-27 00:00:00',440,20,'000009','00009');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000020','2024-05-27 00:00:00',320,20,'000010','00010');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000001','2024-05-27 00:00:00',160,10,'000001','00001');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000025','2024-05-27 00:00:00',240,20,'000005','00005');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000026','2024-05-27 00:00:00',100,10,'000010','00010');
INSERT INTO liuhongkun.provide (flonum,time,totalprice,bundlenumber,supnum,selnum)
 VALUES ('0000001','2024-06-08 11:21:22',160,10,'000001','00002');


-- Name: seller; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE seller (
	selnum character(5) NOT NULL,
	selname character varying(20) NOT NULL,
	province character varying(30),
	city character varying(30),
	contactphone character varying(11),
	password character varying(30) DEFAULT 'sel@123456'::character varying NOT NULL,
	email character varying(20)
)
WITH (orientation=row, compression=no);
ALTER TABLE seller ADD CONSTRAINT pk_seller PRIMARY KEY (selnum);

-- Name: seller; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE seller FROM PUBLIC;
 REVOKE ALL ON TABLE seller FROM liuhongkun;
GRANT ALL ON TABLE seller TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE seller TO cx;
GRANT ALL ON TABLE seller TO chenxu;


--Data for  Name: seller; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00001','邬开承','广东省','广州市','13800138000','sel@123456','xXMs@qq.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00002','江岑千','北京市','北京市','13912345678','sel@123456','EgsU@qq.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00003','曹信豪','上海市','上海市','13778901234','sel@123456','lZZg@qq.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00004','孟舟瑜','浙江省','杭州市','13654321000','sel@123456','hvPC@123.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00005','汤敬赞','江苏省','南京市','13578945612','sel@123456','sujS@hdu.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00006','邓正宇','四川省','成都市','15898765432','sel@123456','EDvA@hdu.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00007','石宁钰','山东省','济南市','15912378900','sel@123456','AQPY@qq.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00008','张素钥','河南省','郑州市','18800001111','sel@123456','ecfn@123.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00009','邢春旭','湖南省','长沙市','18623456789','sel@123456','lFCf@123.com');
INSERT INTO liuhongkun.seller (selnum,selname,province,city,contactphone,password,email)
 VALUES ('00010','穆元苏','陕西省','西安市','18987654321','sel@123456','RYFJ@hdu.com');


-- Name: supplier; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE supplier (
	supnum character(6) NOT NULL,
	supname character varying(20) NOT NULL,
	province character varying(30),
	city character varying(30),
	contactnumber character varying(11),
	password character varying(30) DEFAULT 'sup@123456'::character varying NOT NULL,
	email character varying(20)
)
WITH (orientation=row, compression=no);
ALTER TABLE supplier ADD CONSTRAINT pk_supplier PRIMARY KEY (supnum);

-- Name: supplier; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE supplier FROM PUBLIC;
 REVOKE ALL ON TABLE supplier FROM liuhongkun;
GRANT ALL ON TABLE supplier TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE supplier TO cx;
GRANT ALL ON TABLE supplier TO chenxu;


--Data for  Name: supplier; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000001','詹岭星','北京市','海淀区','13800138000','sup@123456','nlmrso@zoho.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000002','华晗庭','上海市','浦东新区','13900139001','sup@123456','dfqwei@outlook.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000003','仰雪笑','广州市','天河区','13700137002','sup@123456','hzjmbr@zoho.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000004','陆俐钰','深圳市','福田区','13600136003','sup@123456','pvbgwe@qq.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000005','苗锦沛','成都市','锦江区','13500135004','sup@123456','slktod@zoho.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000006','徐登霖','重庆市','渝中区','13400134005','sup@123456','qmprel@outlook.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000007','张蕴湘','南京市','玄武区','13300133006','sup@123456','tbmudk@zoho.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000008','卢尚轲','杭州市','西湖区','13200132007','sup@123456','ecjukm@qq.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000009','杜烽勤','武汉市','武昌区','13100131008','sup@123456','dmuqok@outlook.com');
INSERT INTO liuhongkun.supplier (supnum,supname,province,city,contactnumber,password,email)
 VALUES ('000010','姚宣路','西安市','雁塔区','13000130009','sup@123456','rlgzpe@qq.com');


-- Name: users; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE users (
	id integer DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
	username character varying(50) NOT NULL,
	password character varying(255) NOT NULL
)
WITH (orientation=row, compression=no);
ALTER TABLE users ADD CONSTRAINT users_username_key UNIQUE (username);
ALTER TABLE users ADD CONSTRAINT users_pkey PRIMARY KEY (id);

-- Name: users; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE users FROM PUBLIC;
 REVOKE ALL ON TABLE users FROM liuhongkun;
GRANT ALL ON TABLE users TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE users TO cx;


--Data for  Name: users; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.users (id,username,password)
 VALUES (1,'liuhongkun','$2y$10$9zzjqe605Ub.N7GMhl8JyuHljVLCsnGJoPASTMDnj.elC.w/3VZwm');
INSERT INTO liuhongkun.users (id,username,password)
 VALUES (2,'liuying','$2y$10$xDm4uP83fPNf0Bpqkghit.bosgm2KeV3T5QQPoiCBnMbeGEHF4UtW');


-- Name: warehouse; Type: Table; Schema: liuhongkun;

SET search_path = liuhongkun;
CREATE TABLE warehouse (
	warenum character(4) NOT NULL,
	supnum character(7) NOT NULL,
	area double precision,
	condition character varying(200),
    CONSTRAINT chk_area CHECK ((area > (0)::double precision)),
    CONSTRAINT fk_warehous_manage_supplier FOREIGN KEY (supnum) REFERENCES supplier(supnum) ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (orientation=row, compression=no);
CREATE INDEX manage_fk ON warehouse USING btree (supnum) TABLESPACE pg_default;
ALTER TABLE warehouse ADD CONSTRAINT pk_warehouse PRIMARY KEY (warenum);

-- Name: warehouse; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE warehouse FROM PUBLIC;
 REVOKE ALL ON TABLE warehouse FROM liuhongkun;
GRANT ALL ON TABLE warehouse TO liuhongkun;
GRANT ALL ON TABLE warehouse TO supplier;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE warehouse TO cx;


--Data for  Name: warehouse; Type: Table; Schema: liuhongkun;

INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0001','000001 ',200,' 冷藏柜温度：5°C，正常运行，定期维护；监控系统正常运行，防盗设备正常运转');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0002','000002 ',220,' 冷藏柜温度：4°C，运行稳定，定期检查维护；监控系统完好，防盗设备正常');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0003','000003 ',210,' 冷藏柜温度：6°C，运行正常，定期保养；监控系统工作良好，防盗设备可靠');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0004','000004 ',260,' 冷藏柜温度：3°C，维护良好，定期检查；监控系统正常，防盗设备运行正常');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0005','000005 ',230,' 冷藏柜温度：7°C，设备运行正常，定期维修；监控系统稳定，防盗设备有效');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0006','000006 ',250,' 冷藏柜温度：2°C，运行良好，定期检修；监控系统可靠，防盗设备完好');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0007','000007 ',190,' 冷藏柜温度：8°C，正常运转，定期保养；监控系统工作良好，防盗设备可靠');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0008','000008 ',240,' 冷藏柜温度：1°C，设备运行正常，定期检查维护；监控系统正常，防盗设备有效');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0009','000009 ',225,' 冷藏柜温度：9°C，运行稳定，定期维护；监控系统完好，防盗设备正常');
INSERT INTO liuhongkun.warehouse (warenum,supnum,area,condition)
 VALUES ('0010','000010 ',235,' 冷藏柜温度：0°C，维护良好，定期检查；监控系统正常，防盗设备运行正常');


-- Name: users_id_seq; Type: SEQUENCE OWNED BY ; Schema: liuhongkun;

ALTER SEQUENCE users_id_seq OWNED BY users.id ;

-- Name: SupplierSellerSupply; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun."SupplierSellerSupply"
	AS 
SELECT s.supnum, s.supname, p.selnum, sel.selname, sum(p.bundlenumber) AS totalsupplyquantity, sum(p.totalprice) AS totalsupplyvalue FROM ((supplier s JOIN provide p ON ((s.supnum = p.supnum))) JOIN seller sel ON ((sel.selnum = p.selnum))) GROUP BY s.supnum, s.supname, p.selnum, sel.selname ORDER BY s.supnum, p.selnum;

-- Name: SupplierSellerSupply; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE "SupplierSellerSupply" FROM PUBLIC;
 REVOKE ALL ON TABLE "SupplierSellerSupply" FROM liuhongkun;
GRANT ALL ON TABLE "SupplierSellerSupply" TO liuhongkun;
GRANT SELECT ON TABLE "SupplierSellerSupply" TO supplier;
GRANT SELECT ON TABLE "SupplierSellerSupply" TO seller;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "SupplierSellerSupply" TO cx;


-- Name: customerevaluations; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.customerevaluations
	AS 
SELECT e.onum, o.custnum, c.custname AS customername, i.itemname, e.evalcontent, e.evaltime, e.empreply, e.replytime FROM (((evaluate e JOIN item i ON ((i.itemnum = e.itemnum))) JOIN "Order" o ON ((o.onum = e.onum))) JOIN customer c ON ((o.custnum = c.custnum))) ORDER BY e.evaltime DESC;

-- Name: customerevaluations; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE customerevaluations FROM PUBLIC;
 REVOKE ALL ON TABLE customerevaluations FROM liuhongkun;
GRANT ALL ON TABLE customerevaluations TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE customerevaluations TO cx;


-- Name: employeebasicinfo; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.employeebasicinfo
	AS 
SELECT e.empnum AS employee_number, e.empname AS employee_name, d.deptname AS department_name, e.salary, e.entrydate AS entry_date FROM (employee e JOIN department d ON ((e.deptnum = d.deptnum)));

-- Name: employeebasicinfo; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE employeebasicinfo FROM PUBLIC;
 REVOKE ALL ON TABLE employeebasicinfo FROM liuhongkun;
GRANT ALL ON TABLE employeebasicinfo TO liuhongkun;
GRANT SELECT ON TABLE employeebasicinfo TO cs_staff;
GRANT SELECT ON TABLE employeebasicinfo TO logistics_staff;
GRANT SELECT ON TABLE employeebasicinfo TO d_header;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE employeebasicinfo TO cx;


-- Name: employeeevaluations; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.employeeevaluations
	AS 
SELECT e.onum, e.empnum, em.empname, i.itemname, e.evalcontent, e.evaltime, e.empreply, e.replytime FROM ((evaluate e JOIN item i ON ((i.itemnum = e.itemnum))) JOIN employee em ON ((em.empnum = e.empnum))) ORDER BY e.evaltime DESC;

-- Name: employeeevaluations; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE employeeevaluations FROM PUBLIC;
 REVOKE ALL ON TABLE employeeevaluations FROM liuhongkun;
GRANT ALL ON TABLE employeeevaluations TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE employeeevaluations TO cx;


-- Name: employeeprocessorders; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.employeeprocessorders
	AS 
SELECT e.empnum, e.empname, i.invnum, o.onum, o.ordertime AS "time", i."time" AS shippingtime FROM ((employee e JOIN invoice i ON ((e.empnum = i.empnum))) JOIN "Order" o ON ((o.onum = i.onum)));

-- Name: employeeprocessorders; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE employeeprocessorders FROM PUBLIC;
 REVOKE ALL ON TABLE employeeprocessorders FROM liuhongkun;
GRANT ALL ON TABLE employeeprocessorders TO liuhongkun;
GRANT SELECT ON TABLE employeeprocessorders TO logistics_staff;
GRANT SELECT ON TABLE employeeprocessorders TO seller;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE employeeprocessorders TO cx;


-- Name: logisticsstatistics; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.logisticsstatistics
	AS 
SELECT i.transportation AS shippingmethod, count(i.invnum) AS ordercount, round((sum(o.totalprice))::numeric, 2) AS totalamount FROM (invoice i JOIN "Order" o ON ((i.onum = o.onum))) GROUP BY i.transportation;

-- Name: logisticsstatistics; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE logisticsstatistics FROM PUBLIC;
 REVOKE ALL ON TABLE logisticsstatistics FROM liuhongkun;
GRANT ALL ON TABLE logisticsstatistics TO liuhongkun;
GRANT SELECT ON TABLE logisticsstatistics TO logistics_staff;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE logisticsstatistics TO cx;


-- Name: lowerthan10flowers; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.lowerthan10flowers
	AS 
SELECT f.flonum, f.floname, f.color, f.unit, f.price, f.warenum, f."number" FROM flower f WHERE (f."number" < 10);

-- Name: lowerthan10flowers; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE lowerthan10flowers FROM PUBLIC;
 REVOKE ALL ON TABLE lowerthan10flowers FROM liuhongkun;
GRANT ALL ON TABLE lowerthan10flowers TO liuhongkun;
GRANT SELECT ON TABLE lowerthan10flowers TO supplier;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE lowerthan10flowers TO cx;


-- Name: monthlysalesgrowth; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.monthlysalesgrowth
	AS 
WITH monthlysales AS (SELECT date_trunc('month'::text, o.ordertime) AS month, round((sum(o.totalprice))::numeric, 2) AS monthly_sales FROM "Order" o GROUP BY date_trunc('month'::text, o.ordertime)) SELECT to_char(monthlysales.month, 'YYYY年MM月'::text) AS month, monthlysales.monthly_sales, round(lag(monthlysales.monthly_sales) OVER (ORDER BY monthlysales.month), 2) AS last_month_sales, round((((monthlysales.monthly_sales - lag(monthlysales.monthly_sales) OVER (ORDER BY monthlysales.month)) / NULLIF(lag(monthlysales.monthly_sales) OVER (ORDER BY monthlysales.month), (0)::numeric)) * (100)::numeric), 2) AS growth_rate FROM monthlysales ORDER BY to_char(monthlysales.month, 'YYYY年MM月'::text);

-- Name: monthlysalesgrowth; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE monthlysalesgrowth FROM PUBLIC;
 REVOKE ALL ON TABLE monthlysalesgrowth FROM liuhongkun;
GRANT ALL ON TABLE monthlysalesgrowth TO liuhongkun;
GRANT SELECT ON TABLE monthlysalesgrowth TO sales_staff;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE monthlysalesgrowth TO cx;


-- Name: monthlytopfiveitem; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.monthlytopfiveitem
	AS 
SELECT ranked_items.itemnum, ranked_items.itemname, ranked_items.salesquantity, ranked_items.salemonth FROM (SELECT a.itemnum, i.itemname, sum(a."number") AS salesquantity, date_trunc('month'::text, o.ordertime) AS salemonth, row_number() OVER (PARTITION BY date_trunc('month'::text, o.ordertime) ORDER BY sum(a."number") DESC) AS rank FROM (("ApplyDisc" a JOIN "Order" o ON ((a.onum = o.onum))) JOIN item i ON ((a.itemnum = i.itemnum))) GROUP BY a.itemnum, i.itemname, date_trunc('month'::text, o.ordertime)) ranked_items WHERE (ranked_items.rank <= 5);

-- Name: monthlytopfiveitem; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE monthlytopfiveitem FROM PUBLIC;
 REVOKE ALL ON TABLE monthlytopfiveitem FROM liuhongkun;
GRANT ALL ON TABLE monthlytopfiveitem TO liuhongkun;
GRANT SELECT ON TABLE monthlytopfiveitem TO sales_staff;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE monthlytopfiveitem TO cx;


-- Name: orderlogisticsdetails; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.orderlogisticsdetails
	AS 
SELECT i.invnum, i.onum, a.itemnum, it.itemname, i."time" AS shippingtime, i.transportation AS shippingmethod, (i."time" + '1 day'::interval) AS estimateddeliverytime FROM (((invoice i JOIN "Order" o ON ((i.onum = o.onum))) JOIN "ApplyDisc" a ON ((a.onum = o.onum))) JOIN item it ON ((it.itemnum = a.itemnum))) ORDER BY i.onum;

-- Name: orderlogisticsdetails; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE orderlogisticsdetails FROM PUBLIC;
 REVOKE ALL ON TABLE orderlogisticsdetails FROM liuhongkun;
GRANT ALL ON TABLE orderlogisticsdetails TO liuhongkun;
GRANT SELECT ON TABLE orderlogisticsdetails TO logistics_staff;
GRANT SELECT ON TABLE orderlogisticsdetails TO seller;
GRANT SELECT ON TABLE orderlogisticsdetails TO customer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE orderlogisticsdetails TO cx;


-- Name: recentevaluations; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.recentevaluations
	AS 
SELECT e.onum, c.custnum, c.custname, e.empnum, em.empname, o.paytime, i.itemname, e.evalcontent, e.evaltime, e.empreply, e.replytime FROM ((((evaluate e JOIN item i ON ((i.itemnum = e.itemnum))) JOIN "Order" o ON ((o.onum = e.onum))) JOIN customer c ON ((o.custnum = c.custnum))) JOIN employee em ON ((em.empnum = e.empnum))) WHERE (e.evaltime > (now() - '1 mon'::interval)) ORDER BY e.evaltime DESC;

-- Name: recentevaluations; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE recentevaluations FROM PUBLIC;
 REVOKE ALL ON TABLE recentevaluations FROM liuhongkun;
GRANT ALL ON TABLE recentevaluations TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recentevaluations TO cx;


-- Name: topcustomerpurchaseitem; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.topcustomerpurchaseitem
	AS 
SELECT c.custname, i.itemname, max(a."number") AS maxpurchases FROM ((("ApplyDisc" a JOIN "Order" o ON ((a.onum = o.onum))) JOIN customer c ON ((o.custnum = c.custnum))) JOIN item i ON ((a.itemnum = i.itemnum))) GROUP BY o.custnum, c.custname, i.itemnum ORDER BY o.custnum, max(a."number") DESC;

-- Name: topcustomerpurchaseitem; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE topcustomerpurchaseitem FROM PUBLIC;
 REVOKE ALL ON TABLE topcustomerpurchaseitem FROM liuhongkun;
GRANT ALL ON TABLE topcustomerpurchaseitem TO liuhongkun;
GRANT SELECT ON TABLE topcustomerpurchaseitem TO sales_staff;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE topcustomerpurchaseitem TO cx;


-- Name: unrepliedevaluations; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.unrepliedevaluations
	AS 
SELECT e.onum, i.itemname, o.totalprice, c.custname AS customername, em.empnum, em.empname AS employeename, e.evaltime, e.evalcontent FROM ((((evaluate e JOIN item i ON ((i.itemnum = e.itemnum))) JOIN "Order" o ON ((o.onum = e.onum))) JOIN customer c ON ((o.custnum = c.custnum))) JOIN employee em ON ((e.empnum = em.empnum))) WHERE (e.empreply IS NULL) ORDER BY e.evaltime DESC;

-- Name: unrepliedevaluations; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE unrepliedevaluations FROM PUBLIC;
 REVOKE ALL ON TABLE unrepliedevaluations FROM liuhongkun;
GRANT ALL ON TABLE unrepliedevaluations TO liuhongkun;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE unrepliedevaluations TO cx;


-- Name: warehouseflowerdetails; Type: View; Schema: liuhongkun;


SET search_path = liuhongkun ;
CREATE OR REPLACE VIEW liuhongkun.warehouseflowerdetails
	AS 
SELECT w.warenum, f.flonum, f.floname, f.color, f.unit, f.price, f."number" FROM (warehouse w JOIN flower f ON ((w.warenum = f.warenum))) ORDER BY w.warenum, f.flonum;

-- Name: warehouseflowerdetails; Type: ACL; Schema: liuhongkun;

REVOKE ALL ON TABLE warehouseflowerdetails FROM PUBLIC;
 REVOKE ALL ON TABLE warehouseflowerdetails FROM liuhongkun;
GRANT ALL ON TABLE warehouseflowerdetails TO liuhongkun;
GRANT SELECT ON TABLE warehouseflowerdetails TO supplier;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE warehouseflowerdetails TO cx;


-- Name: users_id_seq; Type: Sequence; Schema: liuhongkun;


SET search_path = liuhongkun ;
 CREATE  SEQUENCE users_id_seq
 START  WITH  1
 INCREMENT  BY  1
 NO MINVALUE  
 MAXVALUE 9223372036854775807
 CACHE 1;

--Data for  Name: users_id_seq; Type: Sequence; Schema: liuhongkun;

SELECT pg_catalog.setVal('users_id_seq',9,true);
