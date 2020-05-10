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

// === Modeling Complex Data / Modeling Unknown Types ===

type Undefined = Nil // Gleam has no exn type

type CustomerInfo = Undefined;
type ShippingAddress = Undefined;
type BillingAddress = Undefined;
type OrderLine = Undefined;
type BillingAmount = Undefined;

type Order {
  Order(
    customer_info: CustomerInfo,
    shipping_address: ShippingAddress,
    billing_address: BillingAddress,
    order_lines: List(OrderLine),
    amount_to_bill: BillingAmount
  )
};

// === Modeling with Choice Types ===

// Dummy type
type GizmoCode = Undefined;

type ProductCode {
  Widget(WidgetCode)
  Gizmo(GizmoCode)
};

type OrderQuantity {
  Unit(UnitQuantity)
  Kilogram(KilogramQuantity)
}

// === Modeling Workflows with Functions ===

type UnvalidatedOrder = Undefined
type ValidatedOrder = Undefined

type ValidateOrder = fn(UnvalidatedOrder) -> ValidatedOrder
