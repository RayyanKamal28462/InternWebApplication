function loadContent(contentType) {
    // Example: you can customize this function to fetch data dynamically via AJAX
    const contentList = document.getElementById('content-list');
    const contentTitle = document.querySelector('.content-title');

    // Clear previous content
    contentList.innerHTML = '';

    // Change the title based on the section clicked
    contentTitle.textContent = contentType;

    // Add dynamic content based on the selected section
    let contentItems = [];
    switch (contentType) {
        case 'Players':
            contentItems = ['Player 1', 'Player 2', 'Player 3', 'Player 4', 'Player 5'];
            break;
        case 'Groups':
            contentItems = ['Group 1', 'Group 2', 'Group 3', 'Group 4'];
            break;
        case 'Assets':
            contentItems = ['Asset 1', 'Asset 2', 'Asset 3'];
            break;
        case 'Playlist':
            contentItems = ['Track 1', 'Track 2', 'Track 3'];
            break;
        case 'Settings':
            contentItems = ['Setting 1', 'Setting 2', 'Setting 3'];
            break;
        default:
            contentItems = ['No content available'];
            break;
    }

    // Populate the content list
    const ul = document.createElement('ul');
    contentItems.forEach(item => {
        const li = document.createElement('li');
        li.textContent = item;
        ul.appendChild(li);
    });
    contentList.appendChild(ul);
}
