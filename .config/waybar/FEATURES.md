# Waybar Features Used

This document lists all the Waybar features currently configured in this setup.

## Core Waybar Modules

### System Information
- **cpu** - CPU usage monitoring with format icons and alt format
- **memory** - Memory usage with states (critical, high, medium) and formatting
- **battery** - Battery status with charging states and time display
- **backlight** - Screen brightness control with scroll actions
- **network** - Network connectivity with WiFi/Ethernet status and bandwidth display

### Audio
- **pulseaudio** - Main audio output control with volume and device management
- **pulseaudio#microphone** - Microphone input control and muting

### Time & Calendar
- **clock** - Time display with calendar tooltip and timezone controls
- **clock##alt** - Alternative clock format (available but not in current layout)

### System Utilities
- **tray** - System tray for applications
- **privacy** - Privacy indicators for screenshare and audio input
- **idle_inhibitor** - Caffeine mode toggle to prevent system sleep

### Media Control
- **mpris** - Media player control (play/pause, track info)

## Hyprland Integration

### Window Management
- **hyprland/workspaces** - Workspace switcher with scroll navigation
- **hyprland/window** - Active window title with application-specific rewrites
- **hyprland/language** - Keyboard layout indicator (available module)

### Task Management
- **wlr/taskbar** - Application taskbar with icon theming and app mapping
- **wlr/taskbar#windows** - Windows-style taskbar variant
- **wlr/taskbar##custom** - Custom taskbar configuration

## Custom Modules

### System Monitoring
- **custom/cpuinfo** - Detailed CPU information via script
- **custom/gpuinfo** - GPU monitoring with vendor variants (nvidia/amd/intel)
- **custom/sensorsinfo** - Hardware sensors information

### Utilities
- **custom/updates** - System update checker
- **custom/keybindhint** - Keybind hints display
- **custom/cliphist** - Clipboard history manager
- **custom/power** - Power/logout menu
- **custom/notifications** - Notification management
- **custom/weather** - Weather information

### Appearance & Themes
- **custom/theme** - Theme switcher
- **custom/wallchange** - Wallpaper changer
- **custom/wbar** - Waybar layout/mode switcher

### Media & Applications
- **custom/spotify** - Spotify integration
- **custom/cava** - Audio visualizer
- **custom/hyprsunset** - Blue light filter control
- **custom/display** - Display configuration
- **custom/bluetooth** - Bluetooth management
- **custom/github_hyde** - GitHub integration

### Layout Elements
- **custom/padd** - Padding spacer
- **custom/l_end** - Left end spacer
- **custom/r_end** - Right end spacer
- **custom/sl_end** - Small left end spacer
- **custom/sr_end** - Small right end spacer
- **custom/rl_end** - Rounded left end spacer
- **custom/rr_end** - Rounded right end spacer

## Configuration Features

### Dynamic Layout System
- Multiple predefined layouts in `config.ctl`
- Generated configuration from modular components
- Position variants: top, bottom, left, right
- Height customization per layout

### Styling Features
- CSS theming with variable support
- Custom fonts (JetBrainsMono Nerd Font)
- Rounded corners and animations
- State-based styling (active, hover, critical states)
- Icon integration with Nerd Font symbols

### Interactive Features
- Click actions (left, right, middle click)
- Scroll actions for volume, brightness, workspace switching
- Tooltips with detailed information
- Keyboard shortcuts integration
