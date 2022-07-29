# Salad

Lightweight Cucumber-style UI testing for iOS.

## Installation

### Swift package manager

Add `https://github.com/Q42/Salad.git` as a dependency of your UI test target(s).

## How it works

The design pattern for testing using Salad consists of four concepts: View Objects, Behaviors, Data Objects and Tests. They are described in more detail below.

We have a simple demo app that shows Salad UI testing in action: [github.com/Q42/Salad.DemoApp](https://github.com/Q42/Salad.DemoApp).

### View Objects

A View Object is a reference to a certain view in the app's UI. During the test run, Salad looks up the matching view in the app by its accessibility identifier.

The view object describes what can be done with the view using properties and methods. 
For example, for a `TodoItemView` object, you are able to read its title label using the `titleLabel` String property.
And for a `ToDoListView`, you can tap a button on it with the `tapAddButton()` method.

If any of these lookups fail, it will fail the UI test.

### Behaviors

Behaviors are used to perform certain actions on views. The protocol consists of one method:

```swift
func perform<FromView: ViewObject, ToView: ViewObject>(from view: FromView) -> ToView
```

Such an action can be navigating between two different views. The `FromView` and `ToView` in the type signature will reflect that.
Or for an action that is local to a view, the `FromView` and `ToView` will be the same, and you stay on the same view.

### Data Objects

Data objects are plain Swift structs used to represent test data.
Deterministic value pickers can be used to select pseudo-random test data using a seeded random number generator.

### Tests

In the test classes, all the above is brought together. They are normal `XCTestCase` classes, but they use a Scenario from Salad to write tests that are less verbose and are more about behavior of your app.
You use the when/then methods to do this.

```swift
override func setUp() {
  valuePicker = try! DeterministicValuePicker(testName: name, seed: .generate)

  let app = XCUIApplication()
  app.launch()
  scenario = Scenario<TodoListView>(given: app)
}

func testCreateTodoItem() {
  let todoItem = valuePicker.pickValue(from: TodoItem.validItems)

  scenario
    .then { view in XCTAssertEqual(view.todoItems.count, 0) }
    .when(CreateTodoItem(title: todoItem.title))
    .then { view in
      XCTAssertEqual(view.todoItems.count, 1)
      XCTAssertEqual(view.todoItems.first?.titleLabel.label, todoItem.title)
    }
}
```

## Version history

* 2022-03-02: 0.0.3 release containing minor fixes
* 2020-01-24: Initial open source release
* 2019-07-01: Initial private version for a project at [Q42](http://q42.com)
