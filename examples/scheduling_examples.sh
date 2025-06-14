#!/bin/bash
# Example commands for using the Dune Weaver scheduling feature

echo "=== Dune Weaver Scheduling Examples ==="
echo ""

# Check current schedule status
echo "1. Checking current schedule status..."
curl -X GET "http://localhost:8080/schedule_status" \
  -H "Content-Type: application/json" | python -m json.tool
echo ""

# Test if current time is within business hours
echo "2. Testing business hours schedule (9 AM - 5 PM)..."
curl -X POST "http://localhost:8080/test_schedule?start_time=09:00&end_time=17:00" \
  -H "Content-Type: application/json" | python -m json.tool
echo ""

# Run a playlist with business hours scheduling
echo "3. Starting a scheduled playlist for business hours..."
curl -X POST "http://localhost:8080/run_playlist" \
  -H "Content-Type: application/json" \
  -d '{
    "playlist_name": "business_patterns",
    "pause_time": 10.0,
    "clear_pattern": "clear_from_center",
    "run_mode": "indefinite",
    "shuffle": false,
    "start_time": "09:00",
    "end_time": "17:00"
  }' | python -m json.tool
echo ""

# Run a playlist with overnight scheduling
echo "4. Starting a scheduled playlist for overnight (10 PM - 6 AM)..."
curl -X POST "http://localhost:8080/run_playlist" \
  -H "Content-Type: application/json" \
  -d '{
    "playlist_name": "night_patterns",
    "pause_time": 5.0,
    "clear_pattern": "clear_from_out",
    "run_mode": "indefinite", 
    "shuffle": true,
    "start_time": "22:00",
    "end_time": "06:00"
  }' | python -m json.tool
echo ""

echo "=== Examples Complete ==="
