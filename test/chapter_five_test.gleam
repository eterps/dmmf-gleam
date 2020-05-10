import dmmf_gleam
import fmt
import gleam/should

// === Modeling Simple Values ===

type CustomerId {
  CustomerId(Int)
};

type WidgetCode {
  WidgetCode(String)
};

type UnitQuantity {
  UnitQuantity(Int)
}

type KilogramQuantity {
  KilogramQuantity(Float)
}

// === Working with Single Case Unions ===

type OrderId {
  OrderId(Int)
}

pub fn ex_1_test() {
  let customer_id = CustomerId(42)
  let order_id = OrderId(42)

  // We can't confuse different types by accident, we get a
  // compiler error:
  //
  // case customer_id == order_id {
  //                     ^^^^^^^^
  // Expected type:
  // 
  //     CustomerId
  // 
  // Found type:
  // 
  //     OrderId

  let CustomerId(inner_value) = customer_id

  inner_value
  |> should.equal(42)
}

pub fn ex_2_test() {
  // construct
  let customer_id = CustomerId(42)

  // deconstruct
  let CustomerId(inner_value) = customer_id

  inner_value
  |> should.equal(42)
}

// fn process_customer_id(CustomerId(inner_value)) {
//   "inner_value is " |> ftm.append(inner_value)
// }
//
// -> Syntax error (Gleam can't deconstruct directly in the
// parameter of a function definition

// === Avoiding Performance Issues with Simple Types

type UnitQuantity3 = Int;
// No translation for [<Struct>]
// No translation for UnitQuantities of int[]
