function Get-ChoosenDates {
    [CmdletBinding()]
    param(
        [System.Collections.IDictionary] $ReportTimes
    )
    $Dates = @(
        # Report Per Hour
        if ($ReportTimes.Contains('PastHour') -and $ReportTimes.PastHour.Enabled) {
            $DatesPastHour = Find-DatesPastHour
            if ($DatesPastHour) {
                $DatesPastHour
            }
        }
        if ($ReportTimes.Contains('CurrentHour') -and $ReportTimes.CurrentHour.Enabled) {
            $DatesCurrentHour = Find-DatesCurrentHour
            if ($DatesCurrentHour) {
                $DatesCurrentHour
            }
        }
        # Report Per Day
        if ($ReportTimes.Contains('PastDay') -and $ReportTimes.PastDay.Enabled) {
            $DatesDayPrevious = Find-DatesDayPrevious
            if ($DatesDayPrevious) {
                $DatesDayPrevious
            }
        }
        if ($ReportTimes.Contains('CurrentDay') -and $ReportTimes.CurrentDay.Enabled) {
            $DatesDayToday = Find-DatesDayToday
            if ($DatesDayToday) {
                $DatesDayToday
            }
        }
        # Report Per Week
        if ($ReportTimes.Contains('OnDay') -and $ReportTimes.OnDay.Enabled) {
            foreach ($Day in $ReportTimes.OnDay.Days) {
                $DatesReportOnDay = Find-DatesPastWeek $Day
                if ($DatesReportOnDay) {
                    $DatesReportOnDay
                }
            }
        }
        # Report Per Month
        if ($ReportTimes.Contains('PastMonth') -and $ReportTimes.PastMonth.Enabled) {
            # Find-DatesMonthPast runs only on 1st of the month unless -Force is used
            $DatesMonthPrevious = Find-DatesMonthPast -Force $ReportTimes.PastMonth.Force
            if ($DatesMonthPrevious) {
                $DatesMonthPrevious
            }
        }
        if ($ReportTimes.Contains('CurrentMonth') -and $ReportTimes.CurrentMonth.Enabled) {
            $DatesMonthCurrent = Find-DatesMonthCurrent
            if ($DatesMonthCurrent) {
                $DatesMonthCurrent
            }
        }
        # Report Per Quarter
        if ($ReportTimes.Contains('PastQuarter') -and $ReportTimes.PastQuarter.Enabled) {
            # Find-DatesMonthPast runs only on 1st of the quarter unless -Force is used
            $DatesQuarterLast = Find-DatesQuarterLast -Force $ReportTimes.PastQuarter.Force
            if ($DatesQuarterLast) {
                $DatesQuarterLast
            }
        }
        if ($ReportTimes.Contains('CurrentQuarter') -and $ReportTimes.CurrentQuarter.Enabled) {
            $DatesQuarterCurrent = Find-DatesQuarterCurrent
            if ($DatesQuarterCurrent) {
                $DatesQuarterCurrent
            }
        }
        # Report Custom
        if ($ReportTimes.Contains('CurrentDayMinusDayX') -and $ReportTimes.CurrentDayMinusDayX.Enabled) {
            $DatesCurrentDayMinusDayX = Find-DatesCurrentDayMinusDayX $ReportTimes.CurrentDayMinusDayX.Days
            if ($DatesCurrentDayMinusDayX) {
                $DatesCurrentDayMinusDayX
            }
        }
        if ($ReportTimes.Contains('CurrentDayMinuxDaysX') -and $ReportTimes.CurrentDayMinuxDaysX.Enabled) {
            $DatesCurrentDayMinusDaysX = Find-DatesCurrentDayMinuxDaysX $ReportTimes.CurrentDayMinuxDaysX.Days
            if ($DatesCurrentDayMinusDaysX) {
                $DatesCurrentDayMinusDaysX
            }
        }
        if ($ReportTimes.Contains('CustomDate') -and $ReportTimes.CustomDate.Enabled) {
            $DatesCustom = @{
                DateFrom = $ReportTimes.CustomDate.DateFrom
                DateTo   = $ReportTimes.CustomDate.DateTo
            }
            if ($DatesCustom) {
                $DatesCustom
            }
        }
        if ($ReportTimes.Contains('Everything') -and $ReportTimes.Everything.Enabled) {
            $DatesEverything = @{
                DateFrom = Get-Date -Year 1600 -Month 1 -Day 1
                DateTo   = Get-Date -Year 2300 -Month 1 -Day 1
            }
            $DatesEverything
        }
        if ($ReportTimes.Contains('Last3days') -and $ReportTimes.Last3days.Enabled) {
            $DatesCurrentDayMinusDaysX = Find-DatesCurrentDayMinuxDaysX -days 3
            if ($DatesCurrentDayMinusDaysX) {
                $DatesCurrentDayMinusDaysX
            }
        }
        if ($ReportTimes.Contains('Last7days') -and $ReportTimes.Last7days.Enabled) {
            $DatesCurrentDayMinusDaysX = Find-DatesCurrentDayMinuxDaysX -days 7
            if ($DatesCurrentDayMinusDaysX) {
                $DatesCurrentDayMinusDaysX
            }
        }
        if ($ReportTimes.Contains('Last14days') -and $ReportTimes.Last14days.Enabled) {
            $DatesCurrentDayMinusDaysX = Find-DatesCurrentDayMinuxDaysX -days 14
            if ($DatesCurrentDayMinusDaysX) {
                $DatesCurrentDayMinusDaysX
            }
        }
    )
    return  $Dates
}