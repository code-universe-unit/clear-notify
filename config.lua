Config = {}
Config.Debug = false -- Set to true to enable debug commands
--Commands : /test_all, /test_good, /test_bad /test_info /test_warning (if Config.Debug is true)

Config.Types = {
    SUCCESS = {
        color = "#00BA88",
    },
    ERROR = {
        color = "#FF4B4B",
    },
    INFO = {
        color = "#0095FF",
    },
    WARNING = {
        color = "#FF8800",
    }
}

Config.DefaultDuration = 5000
Config.Position = "top-right"
Config.MaxNotifications = 4