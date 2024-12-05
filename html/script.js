let config = {
    position: 'top-right',
    distance: 10,
    spacing: 10
};

// Initialize container position
function initializeContainer() {
    const container = document.getElementById('notifications-container');
    
    switch(config.position) {
        case 'top-right':
            container.style.top = config.distance + 'px';
            container.style.right = config.distance + 'px';
            break;
        case 'top-left':
            container.style.top = config.distance + 'px';
            container.style.left = config.distance + 'px';
            break;
        case 'bottom-right':
            container.style.bottom = config.distance + 'px';
            container.style.right = config.distance + 'px';
            break;
        case 'bottom-left':
            container.style.bottom = config.distance + 'px';
            container.style.left = config.distance + 'px';
            break;
    }
}

// Create notification element
function createNotification(data) {
    const notification = document.createElement('div');
    notification.className = `notification ${data.type.toLowerCase()}`;
    notification.id = `notification-${data.id}`;
    
    notification.innerHTML = `
        <div class="notification-icon">
            ${getIconSVG(data.type)}
        </div>
        <div class="notification-content">
            <div class="notification-title">${data.title}</div>
            ${data.message ? `<div class="notification-message">${data.message}</div>` : ''}
        </div>
        ${data.action ? `
            <button class="notification-action" onclick="triggerAction(${data.id}, '${data.action}')">
                ${data.actionLabel || 'Action'}
            </button>
        ` : ''}
        <button class="notification-close" onclick="removeNotification(${data.id})">×</button>
    `;
    
    return notification;
}

// Get icon SVG based on type
function getIconSVG(type) {
    const icons = {
        SUCCESS: `<svg viewBox="0 0 24 24">
            <path d="M20 6L9 17l-5-5" stroke="currentColor" stroke-width="2" fill="none"/>
        </svg>`,
        ERROR: `<svg viewBox="0 0 24 24">
            <path d="M18 6L6 18M6 6l12 12" stroke="currentColor" stroke-width="2" fill="none"/>
        </svg>`,
        INFO: `<svg viewBox="0 0 24 24">
            <path d="M12 16v-4M12 8h.01M12 21a9 9 0 100-18 9 9 0 000 18z" stroke="currentColor" stroke-width="2" fill="none"/>
        </svg>`,
        WARNING: `<svg viewBox="0 0 24 24">
            <path d="M12 8v4m0 4h.01M12 21a9 9 0 100-18 9 9 0 000 18z" stroke="currentColor" stroke-width="2" fill="none"/>
        </svg>`
    };
    return icons[type] || icons.INFO;
}

// Show notification
function showNotification(data) {
    const container = document.getElementById('notifications-container');
    const notification = createNotification(data);
    container.appendChild(notification);
}

// Remove notification
function removeNotification(id) {
    const notification = document.getElementById(`notification-${id}`);
    if (notification) {
        notification.style.animation = 'slideOut 0.3s ease-out forwards';
        setTimeout(() => {
            notification.remove();
        }, 300);
    }
}

// Trigger action callback
function triggerAction(id, action) {
    fetch(`https://${GetParentResourceName()}/notificationAction`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: id,
            action: action
        })
    });
}

// Listen for messages from Lua
window.addEventListener('message', (event) => {
    const data = event.data;
    
    switch(data.action) {
        case 'initialize':
            config = { ...config, ...data.data };
            initializeContainer();
            break;
        case 'showNotification':
            showNotification(data.data);
            break;
        case 'removeNotification':
            removeNotification(data.id);
            break;
    }
});