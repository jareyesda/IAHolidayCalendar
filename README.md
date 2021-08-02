# IAHolidayCalendar
Calendar that will display month data and make a network call to indicate the holidays in the shown month.

## How I am tackling the challenge
First, I will create the calendar UI (Using UIKit) and work on the calendar logic. I will use Swift's Calendar API to create the calendar logic - after the UI is set up, I will work on the networking layer.

## Calendar UI Logic
Because of a traditional calendar's grid pattern, I will use a UICollectionView to create the monthly calendar. Traditional calendars have 42 squares (in the case that a month starts and ends on a Saturday) - so I will populate my UICollectionView cells using a string array of 42 elements. The elements that do not correspond to the month's days will be populated with an empty string, whereas the rest will have their days respectively.
