# PowerShell examples for using the Dune Weaver scheduling feature

Write-Host "=== Dune Weaver Scheduling Examples ===" -ForegroundColor Green
Write-Host ""

# Check current schedule status
Write-Host "1. Checking current schedule status..." -ForegroundColor Yellow
$response = Invoke-RestMethod -Uri "http://localhost:8080/schedule_status" -Method GET
$response | ConvertTo-Json -Depth 3
Write-Host ""

# Test if current time is within business hours
Write-Host "2. Testing business hours schedule (9 AM - 5 PM)..." -ForegroundColor Yellow
$response = Invoke-RestMethod -Uri "http://localhost:8080/test_schedule?start_time=09:00&end_time=17:00" -Method POST
$response | ConvertTo-Json -Depth 3
Write-Host ""

# Run a playlist with business hours scheduling
Write-Host "3. Starting a scheduled playlist for business hours..." -ForegroundColor Yellow
$businessHoursPlaylist = @{
    playlist_name = "business_patterns"
    pause_time = 10.0
    clear_pattern = "clear_from_center"
    run_mode = "indefinite"
    shuffle = $false
    start_time = "09:00"
    end_time = "17:00"
}

$response = Invoke-RestMethod -Uri "http://localhost:8080/run_playlist" -Method POST -Body ($businessHoursPlaylist | ConvertTo-Json) -ContentType "application/json"
$response | ConvertTo-Json -Depth 3
Write-Host ""

# Run a playlist with overnight scheduling
Write-Host "4. Starting a scheduled playlist for overnight (10 PM - 6 AM)..." -ForegroundColor Yellow
$overnightPlaylist = @{
    playlist_name = "night_patterns"
    pause_time = 5.0
    clear_pattern = "clear_from_out"
    run_mode = "indefinite"
    shuffle = $true
    start_time = "22:00"
    end_time = "06:00"
}

$response = Invoke-RestMethod -Uri "http://localhost:8080/run_playlist" -Method POST -Body ($overnightPlaylist | ConvertTo-Json) -ContentType "application/json"
$response | ConvertTo-Json -Depth 3
Write-Host ""

Write-Host "=== Examples Complete ===" -ForegroundColor Green
