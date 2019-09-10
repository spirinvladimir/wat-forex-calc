(module
    (memory (import "js" "mem") 1)
    (func $price_by_amount (param $amount f64) (param $count i32) (result f64)
        (local $i i32)
        (local $price f64)
        (local $sum f64)
        (local $order_price f64)
        (local $order_amount f64)
        (set_local $i (i32.const 0))
        (set_local $price (f64.const 0))
        (set_local $sum (f64.const 0))
        (block $done
            (loop $loop
                (set_local
                    $order_price
                    (f64.load
                        (i32.mul
                            (i32.mul (get_local $i) (i32.const 2))
                            (i32.const 8))))
                (set_local
                    $order_amount
                    (f64.load
                        (i32.mul
                            (i32.add (i32.const 1) (i32.mul (get_local $i) (i32.const 2)))
                            (i32.const 8))))
                (set_local $price (get_local $order_price))
                (set_local $sum (f64.add (get_local $sum) (get_local $order_amount)))
                (set_local $i (i32.add (get_local $i) (i32.const 1)))
                (br_if $done (f64.ge (get_local $sum) (get_local $amount)))
                (br_if $done (i32.eq (get_local $i) (get_local $count)))
                (br $loop)))
        (if (result f64)
            (f64.lt (get_local $sum) (get_local $amount))
            (f64.const 0)
            (get_local $price))
    )
    (func $add (param $a f64) (param $b f64) (result f64)
        (f64.add
            (get_local $a)
            (get_local $b)))
    (func $sub (param $a f64) (param $b f64) (result f64)
        (f64.sub
            (get_local $a)
            (get_local $b)))
    (func $mul (param $a f64) (param $b f64) (result f64)
        (f64.mul
            (get_local $a)
            (get_local $b)))
    (func $div (param $a f64) (param $b f64) (result f64)
        (f64.div
            (get_local $a)
            (get_local $b)))
    (func $buy (param $amount f64) (param $price f64) (param $commission f64) (result f64)
        (f64.mul
            (f64.mul
                (get_local $amount)
                (get_local $price))
            (f64.sub
                (f64.const 1)
                (get_local $commission))))
    (func $sell (param $amount f64) (param $price f64) (param $commission f64) (result f64)
        (f64.div
            (f64.div
                (get_local $amount)
                (get_local $price))
            (f64.add
                (f64.const 1)
                (get_local $commission))))
    (export "add" (func $add))
    (export "sub" (func $sub))
    (export "mul" (func $mul))
    (export "div" (func $div))
    (export "buy" (func $buy))
    (export "sell" (func $sell))
    (export "price_by_amount" (func $price_by_amount))
)
