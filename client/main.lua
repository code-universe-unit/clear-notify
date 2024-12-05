local notifications = {}
local currentNotificationId = 0

CreateThread(function()
    SendNUIMessage({
        action = "initialize",
        data = {
            position = Config.Position,
            distance = Config.Distance,
            spacing = Config.Spacing
        }
    })
end)

local function ShowNotification(data)
    currentNotificationId = currentNotificationId + 1
    local notificationData = {
        id = currentNotificationId,
        title = data.title or "",
        message = data.message or "",
        type = data.type or "INFO",
        duration = data.duration or Config.DefaultDuration,
        action = data.action,
        actionLabel = data.actionLabel
    }

    table.insert(notifications, notificationData)

    while #notifications > Config.MaxNotifications do
        table.remove(notifications, 1)
    end

    SendNUIMessage({
        action = "showNotification",
        data = notificationData
    })

    if notificationData.duration > 0 then
        SetTimeout(notificationData.duration, function()
            RemoveNotification(notificationData.id)
        end)
    end

    return notificationData.id
end

function RemoveNotification(id)
    for i, notification in ipairs(notifications) do
        if notification.id == id then
            table.remove(notifications, i)
            SendNUIMessage({
                action = "removeNotification",
                id = id
            })
            break
        end
    end
end

if Config.Debug then
    RegisterCommand('test_all', function()
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "SUCCESS",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "ERROR",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "INFO",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "WARNING",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    end)
    
    RegisterCommand('test_good', function()
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "SUCCESS",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    end)
    
    RegisterCommand('test_bad', function()
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "ERROR",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    end)
    
    RegisterCommand('test_info', function()
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "INFO",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    end)
    
    RegisterCommand('test_warning', function()
        ShowNotification({
            title = "Test Notification",
            message = "This is a test notification",
            type = "WARNING",
            duration = 50000,
            action = "testAction",
            actionLabel = "Test Action"
        })
    end)
end



-- Export functions
exports('ShowNotification', ShowNotification)
exports('RemoveNotification', RemoveNotification)

-- Register NUI Callback for action buttons
RegisterNUICallback('notificationAction', function(data, cb)
    if data.action then
        TriggerEvent('notifications:actionClicked', data.id, data.action)
    end
    cb('ok')
end)
