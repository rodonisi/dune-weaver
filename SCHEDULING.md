# Scheduling Feature Documentation

The Dune Weaver now supports time-based scheduling for playlists through both the web UI and API. This allows you to run playlists only during specific time periods.

## How It Works

When you schedule a playlist, the system will:

1. Wait until the scheduled start time (if not already within the scheduled period)
2. Run the playlist only during the scheduled hours
3. Pause execution when outside the scheduled hours
4. Resume execution when back within the scheduled hours

## Using the Web UI

### Setting Up a Scheduled Playlist

1. **Navigate to the Playlists tab** in the web interface
2. **Select a playlist** to open the playlist editor
3. **Configure Playlist Settings:**

   - Choose run mode (Once or Indefinitely)
   - Set pause time between patterns
   - Select clear pattern (optional)
   - Enable shuffle (optional)

4. **Set Schedule (Optional):**

   - **Start Time**: Enter time in 24-hour format (e.g., 09:00)
   - **End Time**: Enter time in 24-hour format (e.g., 17:00)
   - Leave both fields empty for no scheduling (runs immediately)

5. **Visual Status Indicator:**

   - The UI will show whether the current time is within the scheduled range
   - Green text: "Currently ACTIVE" (playlist will run now)
   - Orange text: "Currently INACTIVE" (playlist will wait for scheduled time)

6. **Click Play** to start the scheduled playlist

### Time Format

- Use 24-hour format: `HH:MM`
- Examples: `09:00`, `17:30`, `23:59`

### Schedule Types

1. **Same-day schedule**: `09:00` to `17:00` (9 AM to 5 PM)
2. **Overnight schedule**: `22:00` to `06:00` (10 PM to 6 AM)
3. **No schedule**: Leave both fields empty for 24/7 operation

## Examples

### Business Hours Schedule (9 AM - 5 PM)

- Start Time: `09:00`
- End Time: `17:00`
- Run Mode: Indefinitely
- Perfect for daytime-only operation

### Night Schedule (10 PM - 6 AM)

- Start Time: `22:00`
- End Time: `06:00`
- Run Mode: Indefinitely
- Great for overnight patterns when noise won't be an issue

### Weekend Long Runner

- Start Time: `00:00`
- End Time: `23:59`
- Run Mode: Indefinitely
- Essentially runs all day with scheduling enabled

## Behavior Notes

- The playlist will pause when outside scheduled hours and resume when back in schedule
- If Run Mode is "Indefinitely", the playlist will continue to loop during scheduled hours
- Use Run Mode "Once" to run the playlist only once during the scheduled period
- The system checks the schedule before each pattern in the playlist
- Scheduling is optional - if no times are provided, the playlist runs immediately
- The status indicator updates in real-time to show current schedule status

## API Usage (Advanced)

For programmatic access, use the `/run_playlist` endpoint with these additional parameters:

```json
{
  "playlist_name": "your_playlist_name",
  "pause_time": 5.0,
  "clear_pattern": "clear_from_center",
  "run_mode": "indefinite",
  "shuffle": false,
  "start_time": "09:00",
  "end_time": "17:00"
}
```
