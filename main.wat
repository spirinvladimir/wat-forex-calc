(module
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
)