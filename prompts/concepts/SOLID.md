### SOLID Principles in JavaScript (JS Examples)

SOLID is a set of five design principles for writing maintainable and scalable object-oriented software. Let's break each one down with JavaScript examples.

---

## 1. **S**ingle Responsibility Principle (SRP)

*A class/module should have only one reason to change.*

### **Bad Example**

The `User` class handles both user data and email notifications.

```js
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  saveToDatabase() {
    console.log(`Saving ${this.name} to database.`);
  }

  sendWelcomeEmail() {
    console.log(`Sending welcome email to ${this.email}.`);
  }
}
```

**Why is this bad?**
This class is responsible for both **storing user data** and **sending emails**, violating SRP.

### **Good Example**

Separate the concerns into different classes:

```js
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }
}

class UserRepository {
  save(user) {
    console.log(`Saving ${user.name} to database.`);
  }
}

class EmailService {
  sendWelcomeEmail(user) {
    console.log(`Sending welcome email to ${user.email}.`);
  }
}
```

**Now:**

* `UserRepository` handles database operations.
* `EmailService` handles email-related logic.

---

## 2. **O**pen/Closed Principle (OCP)

*Software entities should be open for extension but closed for modification.*

### **Bad Example**

Each time we add a new payment method, we modify the `PaymentProcessor` class:

```js
class PaymentProcessor {
  pay(method, amount) {
    if (method === "creditCard") {
      console.log(`Paid ${amount} using Credit Card.`);
    } else if (method === "paypal") {
      console.log(`Paid ${amount} using PayPal.`);
    }
  }
}
```

**Why is this bad?**

* Every new payment method requires modifying `pay()`, breaking OCP.

### **Good Example**

Use **polymorphism** to make the system extendable:

```js
class PaymentMethod {
  pay(amount) {
    throw new Error("Method not implemented.");
  }
}

class CreditCard extends PaymentMethod {
  pay(amount) {
    console.log(`Paid ${amount} using Credit Card.`);
  }
}

class PayPal extends PaymentMethod {
  pay(amount) {
    console.log(`Paid ${amount} using PayPal.`);
  }
}

class PaymentProcessor {
  processPayment(paymentMethod, amount) {
    paymentMethod.pay(amount);
  }
}

// Usage
const paymentProcessor = new PaymentProcessor();
paymentProcessor.processPayment(new CreditCard(), 100);
paymentProcessor.processPayment(new PayPal(), 50);
```

**Now:**

* We can add new payment methods without modifying existing code.

---

## 3. **L**iskov Substitution Principle (LSP)

*Subtypes must be substitutable for their base types.*

### **Bad Example**

The `Bird` class has a method that doesn’t apply to all birds.

```js
class Bird {
  fly() {
    console.log("I can fly!");
  }
}

class Penguin extends Bird {}

const penguin = new Penguin();
penguin.fly(); // ❌ Penguins can't fly!
```

**Why is this bad?**

* `Penguin` extends `Bird`, but it **cannot fly**, violating LSP.

### **Good Example**

Use **separate** base classes:

```js
class Bird {
  makeSound() {
    console.log("Chirp!");
  }
}

class FlyingBird extends Bird {
  fly() {
    console.log("I can fly!");
  }
}

class Sparrow extends FlyingBird {}
class Penguin extends Bird {}

const sparrow = new Sparrow();
sparrow.fly(); // ✅ Works fine

const penguin = new Penguin();
penguin.fly(); // ❌ Now correctly not allowed
```

**Now:**

* `Penguin` does not inherit `fly()`, following LSP.

---

## 4. **I**nterface Segregation Principle (ISP)

*Clients should not be forced to depend on methods they do not use.*

### **Bad Example**

A `Worker` class enforces methods that some subclasses don’t need.

```js
class Worker {
  work() {
    console.log("Working...");
  }

  eat() {
    console.log("Eating...");
  }
}

class Robot extends Worker {}

const robot = new Robot();
robot.eat(); // ❌ Robots don’t eat!
```

**Why is this bad?**

* `Robot` doesn’t need `eat()`, violating ISP.

### **Good Example**

Split interfaces:

```js
class Workable {
  work() {
    console.log("Working...");
  }
}

class Eatable {
  eat() {
    console.log("Eating...");
  }
}

class Human extends Workable {
  constructor() {
    super();
    this.eatable = new Eatable();
  }
}

class Robot extends Workable {}

const human = new Human();
human.work();
human.eatable.eat(); // ✅ Only humans eat

const robot = new Robot();
robot.work(); // ✅ No unnecessary methods
```

**Now:**

* `Robot` isn’t forced to implement `eat()`.

---

## 5. **D**ependency Inversion Principle (DIP)

*High-level modules should not depend on low-level modules. Both should depend on abstractions.*

### **Bad Example**

The `Store` class directly depends on `PayPalPayment`, making it hard to switch payment methods.

```js
class PayPalPayment {
  pay(amount) {
    console.log(`Paying ${amount} via PayPal`);
  }
}

class Store {
  constructor() {
    this.paymentProcessor = new PayPalPayment();
  }

  checkout(amount) {
    this.paymentProcessor.pay(amount);
  }
}
```

**Why is this bad?**

* If we want to add `CreditCardPayment`, we must modify `Store`.

### **Good Example**

Depend on **abstractions** (interfaces):

```js
class PaymentProcessor {
  pay(amount) {
    throw new Error("Method not implemented.");
  }
}

class PayPalPayment extends PaymentProcessor {
  pay(amount) {
    console.log(`Paying ${amount} via PayPal`);
  }
}

class CreditCardPayment extends PaymentProcessor {
  pay(amount) {
    console.log(`Paying ${amount} via Credit Card`);
  }
}

class Store {
  constructor(paymentProcessor) {
    this.paymentProcessor = paymentProcessor;
  }

  checkout(amount) {
    this.paymentProcessor.pay(amount);
  }
}

// Usage
const store1 = new Store(new PayPalPayment());
store1.checkout(100);

const store2 = new Store(new CreditCardPayment());
store2.checkout(200);
```

**Now:**

* `Store` depends on `PaymentProcessor` (an abstraction), making it easy to swap payment methods.

---

### **Conclusion**

Applying SOLID principles makes JavaScript code:
✅ More maintainable
✅ Easier to extend
✅ More robust and testable
