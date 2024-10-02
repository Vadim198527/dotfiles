function randomIntFromInterval(min, max) { // min and max included
    return Math.floor(Math.random() * (max - min + 1) + min)
}
function createListOfDivs(container) {
    const childernItems = container.children;
    const list = [];
    for (let i = 0; i < childernItems.length; i++) {
        const item = childernItems[i];
        if (item.classList.contains('OrderSnippetContainerStyles__Container-sc-26tlak-0')) {
            list.push(item);
        }
    }
    return list;
}

function createListsOfLinksAndIds(lisOfDivs, oldListOfIds) {
    const listOfLinks = [];
    const listOfIds = {};
    for (let i = 0; i < lisOfDivs.length; i++) {
        const divItem = lisOfDivs[i];
        const a = divItem.querySelector('a');
        if (a) {
            const id = divItem.querySelector('a').id;
            const href = divItem.querySelector('a').href;
            if (!oldListOfIds || !oldListOfIds[id]) {
                listOfLinks.push(href);
            }
            listOfIds[id] = 1;
        }
    }
    return { listOfLinks, listOfIds };
}

function sendRequest(url) {
    function sendToTelegram(message) {
        const url = 'https://api.telegram.org/bot5139954590:AAG39dMY23nH2E0JxMICSGuVPVQ-wdZc9rc/sendMessage?chat_id=@vadim198527&parse_mode=HTML&text=' +
            message;
        const newTabForBot = window.open(url);
        setTimeout(() => {
            newTabForBot.close();
        }, 1000);
    }

    const newTab = window.open(url);
    newTab.onload = () => {
        setTimeout(() => {
            // btnSendMessage.click();
            sendToTelegram(url);
            setTimeout(() => {
                newTab.close();
            }, 1000);
        }, 1500);
    };
}

const container = document.getElementById('content-content');
let listOfDivs = createListOfDivs(container);
const oldListOfIds = JSON.parse(localStorage.getItem('old_list'));
const { listOfLinks, listOfIds } = createListsOfLinksAndIds(listOfDivs, oldListOfIds);
console.log(listOfLinks, listOfIds);


let i = 0;
let idInt = setInterval(() => {
    if (i < listOfLinks.length) {
        sendRequest(listOfLinks[i++]);
    } else {
        clearInterval(idInt);
    }
}, 2000);
localStorage.setItem('old_list', JSON.stringify(listOfIds));
