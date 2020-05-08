import dmmf_gleam
import gleam/string
import gleam/int
import gleam/float
import gleam/should

// === 4. Type Signatures ===

fn add1(x) { x + 1 }    // signature is: int -> int
pub fn ex_1_test() { add1(3) |> should.equal(4) }

fn add(x, y) { x + y }  // signature is: (int, int) -> int
pub fn ex_2_test() { add(3, 2) |> should.equal(5) }

fn square_plus_one(x) {
  let square = x * x
  square + 1
}
pub fn ex_3_test() { square_plus_one(3) |> should.equal(10) }

// === 4. Functions with Generic Types ===

// (a, a) -> bool
fn are_equal(x, y) { x == y }
pub fn ex_4_test() {
  are_equal(2, 2) |> should.equal(True)
  are_equal("foo", "foo") |> should.equal(True)
}

// === 4. "AND" Types ===

type AppleVariety {
  GoldenDelicious
  GrannySmith
  Fuji
}
type BananaVariety {
  Cavendish
  GrosMichel
  Manzano
}
type CherryVariety {
  Montmorency
  Bing
}

type FruitSalad {
  FruitSalad(
    apple: AppleVariety,
    banana: BananaVariety,
    cherries: CherryVariety)
}

// === 4. "OR" Types ===

type FruitSnack {
  Apple(AppleVariety)
  Banana(BananaVariety)
  Cherries(CherryVariety)
}

// === 4. Simple Types ===

type ProductCode {
  ProductCode(String)
}

// === 4. Working with Types ===

type Person {
  Person(first: String, last: String)
}

pub fn ex_5_test() {
  let a_person = Person(first: "Alex", last: "Adams")
  a_person.first |> should.equal("Alex")
  a_person.last |> should.equal("Adams")

  let Person(first: first, last: last) = a_person
  first |> should.equal("Alex")
  last |> should.equal("Adams")
}

type OrderQuantity {
  UnitQuantity(Int)
  KilogramQuantity(Float)
}

fn get_quantity(an_order_qty) {
  case an_order_qty {
    UnitQuantity(u_qty) -> int.to_string(u_qty) |> string.append(" units")
    KilogramQuantity(kg_qty) -> float.to_string(kg_qty) |> string.append(" kg")
  }
}

pub fn ex_6_test() {
  let an_order_qty_in_units = UnitQuantity(10)
  let an_order_qty_in_kg = KilogramQuantity(2.5)
  get_quantity(an_order_qty_in_units) |> should.equal("10 units")
  get_quantity(an_order_qty_in_kg) |> should.equal("2.5 kg")
}

// === 4. Building a Domain Model by Composing Types ===

type CheckNumber { CheckNumber(Int) }
type CardNumber { CardNumber(String) }
type CardType {
  Visa
  Mastercard
}
type CreditCardInfo {
  CreditCardInfo(card_type: CardType, card_number: CardNumber)
}
type PaymentMethod {
  Cash
  Check(CheckNumber)
  Card(CreditCardInfo)
}
type PaymentAmount { PaymentAmount(Float) }
type Currency {
  EUR
  USD
}
type Payment {
  Payment(
    amount: PaymentAmount,
    currency: Currency,
    method: PaymentAmount)
}
// type PayInvoice // UNSUPPORTED: Gleam has no function types yet
// type ConvertPaymentCurrency // UNSUPPORTED: Gleam has no function types yet
