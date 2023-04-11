var available = [];
  
var sold = [];

function setupProperties(data) {
    var btn = document.getElementsByClassName("nav-button");
    for (var i = 0; i < btn.length; i++) {
      btn[i].addEventListener("click", function() {
        // set button active
        var active = document.getElementsByClassName("active");
        for (var x = 0; x < active.length; x++) {
            active[x].classList.remove("active");
        }
        this.classList.toggle("active");
        if (this.id == "available") {
            document.getElementById("sold-properties").style.display = "none";
            document.getElementById("available-properties").style.display = "block";
        } else if (this.id == "sold") {
            document.getElementById("available-properties").style.display = "none";
            document.getElementById("sold-properties").style.display = "block";
        }
      });
    }

    // Store data
    available = [];
    sold = [];
    if (data && data.available && data.sold) {
        for (const property in data.available) {
            available.push({
                id: data.available[property].id,
                address: data.available[property].address,
                price: data.available[property].price,
                tier: data.available[property].tier
            });
        }
        for (const property in data.sold) {
            sold.push({
                id: data.sold[property].id,
                address: data.sold[property].address,
                owner: data.sold[property].owner,
                keyholders: data.sold[property].keyholders
            });
        }
    } else {
        available = mock_available;
        sold = mock_sold;
    }

    // Add table rows for each available property
    const availablePropertyList = document.querySelector("#available-property-list");
    available.forEach(function(property) {
        const tr = document.createElement("tr");
        tr.setAttribute("id", "available-" + property.id);
        tr.innerHTML = `
          <td>${property.address}</td>
          <td>$${property.price.toLocaleString()}</td>
          <td>${property.tier}</td>
          <td>
            <button class="action-btn tier-btn tooltip"><i class="fa fa-arrow-up"></i><span class="tooltiptext">Set Property Tier</span></button>
            <button class="action-btn price-btn tooltip"><i class="fa fa-usd"></i><span class="tooltiptext">Set Property Price</span></button>
            <button class="action-btn trash-btn tooltip"><i class="fa fa-trash"></i><span class="tooltiptext">Delete Property</span></button>
          </td>
        `;
        availablePropertyList.appendChild(tr);
    });

    // Add table rows for each sold property
    const soldPropertyList = document.querySelector("#sold-property-list");
    sold.forEach(function(property) {
        const tr = document.createElement("tr");
        tr.setAttribute("id", "sold-" + property.id);
        tr.innerHTML = `
        <td>${property.address}</td>
        <td>${property.owner}</td>
        <td>${property.keyholders}</td>
        <td><button class="action-btn transfer-btn tooltip"><i class="fa fa-exchange" aria-hidden="true"></i><span class="tooltiptext">Transfer Property</span></button></td>
        `;
        soldPropertyList.appendChild(tr);
    });

    var buttons = document.getElementsByClassName("action-btn");
    for (var i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener("click", function() {
            var cls = this.classList;
            var id = this.parentNode.parentNode.getAttribute('id');
            if (cls.contains('tier-btn')) {
                ShowInputModal('tier', 'Enter tier to set property to...', 'Confirm', 'Cancel', id);
                return
            } else if (cls.contains('price-btn')) {
                ShowInputModal('price', 'Enter price to set property to...', 'Confirm', 'Cancel', id);
                return
            } else if (cls.contains('trash-btn')) {
                ShowConfirmModal(` - Are you sure you wish to delete this property?\n\n<p style="color:red;">BEWARE: THIS WILL DELETE THIS ADDRESS PERMANANTLY AND WILL DELETE ANY OWNED PROPERTIES AT THIS ADDRESS!</p>`, 'Yes', 'No', id);
                return
            } else if (cls.contains('transfer-btn')) {
                ShowInputModal('transfer', `Enter CitizenID to transfer property to...\n\n<p style="color:red;">BEWARE: THIS WILL REMOVE ALL ADDITIONAL KEYHOLDERS FROM THE PROPERTY!</p>`, 'Confirm', 'Cancel', id);
                return
            }
        });
    }
};

function ShowConfirmModal(text, button1, button2, id) {
    const modal = document.getElementById('confirm-modal');
    const modalText = modal.querySelector('#confirm-modal-text');
    const modalButton1 = modal.querySelector('#confirm-modal-button1');
    const modalButton2 = modal.querySelector('#confirm-modal-button2');
    const tablerow = document.getElementById(id);

    modalText.innerHTML = tablerow.cells[0].innerHTML + text;
    modalButton1.innerText = button1;
    modalButton2.innerText = button2;

    modal.showModal();
    
    const controller = new AbortController();
    const { signal } = controller;

    modalButton1.addEventListener('click', function button1 (event) {
        const propertyId = id.split("-")[1];
        PostCallback('deleteProperty', { propertyId: propertyId });
        tablerow.remove();
        const tablerowsold = document.getElementById("sold-" + id.split("-")[1]);
        tablerowsold.remove();
        event.stopPropagation();
        event.preventDefault();
        modal.close();
        controller.abort();
    }, { signal });

    modalButton2.addEventListener('click', function button2 (event) {
        event.preventDefault();
        modal.close();
        controller.abort();
    }, { signal });
}

function ShowInputModal(type, text, button1, button2, id) {
    const modal = document.getElementById('input-modal');
    const modalText = modal.querySelector('#input-modal-text');
    const modalInput = modal.querySelector('#input-modal-input');
    const modalButton1 = modal.querySelector('#input-modal-button1');
    const modalButton2 = modal.querySelector('#input-modal-button2');
    const tablerow = document.getElementById(id);

    modalText.innerHTML = text;
    modalButton1.innerText = button1;
    modalButton2.innerText = button2;

    modalText.style.marginTop = '3vh';

    if (type == 'tier') {
        modalInput.value = tablerow.cells[2].innerHTML;
    } else if (type == 'transfer') {
        const array = tablerow.cells[1].innerHTML.split(" ");
        const lastElement = array[array.length - 1];
        const citizenId = lastElement.replace('(', '').replace(')', '');
        modalInput.value = citizenId;

        modalText.style.marginTop = '1vh';
    } else if (type == 'price') {
        var newvalue = tablerow.cells[1].innerHTML.replace('$', '');
        newvalue = newvalue.replace(',', '');
        modalInput.value = newvalue;
    }

    modal.showModal();

    const controller = new AbortController();
    const { signal } = controller;

    modalButton1.addEventListener('click', function button1 (event) {
        const propertyId = id.split("-")[1];
        if (type == 'tier') {
            PostCallback('setPropertyTier', { propertyId: propertyId, newTier: Number(modalInput.value) });
            tablerow.cells[2].innerHTML = modalInput.value;
        } else if (type == 'price') {
            if (Number(modalInput.value) >= 0) {
                PostCallback('setPropertyPrice', { propertyId: propertyId, newPrice: Number(modalInput.value) });
                tablerow.cells[1].innerHTML = '$' + Number(modalInput.value).toLocaleString();    
            }
        } else if (type == 'transfer') {
            PostCallback('transferProperty', { propertyId: propertyId, newOwner: modalInput.value }, function(data) {
                tablerow.cells[1].innerHTML = data.owner;
                tablerow.cells[2].innerHTML = data.keyholders;
            });
        }
        event.stopPropagation();
        event.preventDefault();
        modal.close();
        controller.abort();
    }, { signal });

    modalButton2.addEventListener('click', function button2 (event) {
        event.stopPropagation();
        event.preventDefault();
        modal.close();
        controller.abort();
    }, { signal });
}

function Cleanup() {
    // Clear table data
    const availablePropertyList = document.querySelector("#available-property-list");
    availablePropertyList.innerHTML = "";
    const soldPropertyList = document.querySelector("#sold-property-list");
    soldPropertyList.innerHTML = "";
}

function PostCallback(endpoint, body, callback) {
    fetch(`https://${GetParentResourceName()}/${endpoint}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(body)
    }).then(resp => resp.json()).then(resp => { callback(resp) });
}

window.addEventListener("message", (event) => {
	var item = event.data;
	if (item.showmenu){
        document.body.style.display = "block";
        setupProperties(item.properties);
    }
});

document.onkeyup = function(data){
	if (data.which == 27){
	    document.body.style.display = "none";
        Cleanup();
        PostCallback('close');
	};
};

// Modals

// Confirm modal
