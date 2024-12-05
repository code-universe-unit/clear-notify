# Clear Notify

An advanced, customizable notification system for FiveM servers by Code Universe.

## Features

- Multiple notification types: Success, Error, Info, Warning
- Customizable positions: top-right, top-left, bottom-right, bottom-left
- Adjustable duration for each notification
- Interactive action buttons
- Smooth animations
- Easily integrates with existing scripts
- Fully customizable styling

## Quick Start

1. Download and install Clear Notify in your FiveM resources folder.
2. Add `ensure clear-notify` to your server.cfg file.
3. Use the export to show a notification:

```lua
exports['clear-notify']:ShowNotification({
    title = "Welcome",
    message = "Thanks for using Clear Notify!",
    type = "SUCCESS",
    duration = 5000
})