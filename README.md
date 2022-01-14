# BudgetTrackeriOS

BudgetTrackeriOS is the Starter project that's used for the Testing Fundamentals in iOS course on [Pluralsight](https://app.pluralsight.com/library/courses/testing-fundamentals-ios/table-of-contents). This takes the initial project that is part of the original course published in 2019 with the following changes:

- model IDs are of type `UUID` instead of `Int` to match the updated [Vapor 4 server](https://github.com/jonathanwong/BudgetTracker)
- api client methods are updated to match the model ID changes
- `Employee.WithTraining` is simplified now to just return `[Trainings]` in api client