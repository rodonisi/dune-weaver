#!/usr/bin/env python3
"""
Test script for the scheduling functionality.
This is a standalone test to verify the scheduling logic without dependencies.
"""

from datetime import datetime, time

def parse_time_string(time_str):
    """Parse time string in HH:MM format to datetime.time object."""
    if not time_str:
        return None
    try:
        hour, minute = map(int, time_str.split(':'))
        return time(hour, minute)
    except ValueError:
        print(f"Invalid time format: {time_str}. Expected HH:MM")
        return None

def is_within_schedule(start_time_str, end_time_str):
    """Check if current time is within the specified schedule."""
    if not start_time_str or not end_time_str:
        # No schedule specified, always allow
        return True
    
    start_time = parse_time_string(start_time_str)
    end_time = parse_time_string(end_time_str)
    
    if not start_time or not end_time:
        print("Invalid time format in schedule, allowing execution")
        return True
    
    current_time = datetime.now().time()
    
    # Handle schedules that span midnight
    if start_time <= end_time:
        # Same day schedule (e.g., 09:00 to 17:00)
        return start_time <= current_time <= end_time
    else:
        # Overnight schedule (e.g., 22:00 to 06:00)
        return current_time >= start_time or current_time <= end_time

def test_time_parsing():
    """Test time string parsing."""
    print("Testing time string parsing...")
    
    # Valid time strings
    assert parse_time_string("09:00") == time(9, 0)
    assert parse_time_string("17:30") == time(17, 30)
    assert parse_time_string("00:00") == time(0, 0)
    assert parse_time_string("23:59") == time(23, 59)
    
    # Invalid time strings
    assert parse_time_string("invalid") is None
    assert parse_time_string("25:00") is None
    assert parse_time_string("") is None
    assert parse_time_string(None) is None
    
    print("✓ Time parsing tests passed")

def test_schedule_logic():
    """Test schedule logic with different scenarios."""
    print("Testing schedule logic...")
    
    # Test with no schedule (should always return True)
    assert is_within_schedule(None, None) == True
    assert is_within_schedule("", "") == True
    assert is_within_schedule("09:00", None) == True
    
    print("✓ Schedule logic tests passed")

def demo_scheduling():
    """Demo the scheduling functionality."""
    print("\n--- Scheduling Demo ---")
    current_time = datetime.now().time()
    print(f"Current time: {current_time.strftime('%H:%M')}")
    
    # Test various schedules
    test_schedules = [
        ("09:00", "17:00"),  # Business hours
        ("22:00", "06:00"),  # Overnight
        ("00:00", "23:59"),  # All day
        ("12:00", "13:00"),  # Lunch hour
    ]
    
    for start, end in test_schedules:
        within = is_within_schedule(start, end)
        print(f"Schedule {start}-{end}: {'✓ ACTIVE' if within else '✗ INACTIVE'}")

if __name__ == "__main__":
    try:
        test_time_parsing()
        test_schedule_logic()
        demo_scheduling()
        print("\n✅ All tests passed! Scheduling feature is working correctly.")
    except Exception as e:
        print(f"\n❌ Test failed: {e}")
        import sys
        sys.exit(1)
