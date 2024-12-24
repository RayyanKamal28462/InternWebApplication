<%@ Page Title="Rearrange Content" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RearrangeContent.aspx.cs" Inherits="InternWebApplication.RearrangeContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>

  <style>
    /* General page styling */
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f3f4f8;
    }

    .content-wrapper {
        padding: 20px;
        margin: 0 auto;
        max-width: 100%;
    }

    /* Video Container */
    .video-container {
        width: 100%;
        height: 400px;
        background-color: khaki;
        border-radius: 8px;
        display: flex;
        justify-content: center;
        align-items: center;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        padding-left: 10px;
 

    }

    .video-container:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    }
      .video-slider-container {
    display: flex;
    align-items: center;
    position: relative;
    overflow: hidden;
    width: 100%; /* Adjust to your container width */
}

.video-slider {
    display: flex;
    transition: transform 0.5s ease-in-out;
}

.video-item {
    margin-right: 10px; /* Space between videos */
    flex-shrink: 0;
}

.slider-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    font-size: 24px;
    padding: 10px;
    cursor: pointer;
    z-index: 10;
}

.left {
    left: 10px;
}

.right {
    right: 10px;
}

.slider-btn:hover {
    background-color: rgba(0, 0, 0, 0.7);
}

    /* Layout for Content and Input Containers */
    .content-layout {
        display: flex;
        justify-content: space-between;
        gap: 20px;
    }

    .content-container {
        width: 48%;
        background-color: #fff;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        padding: 20px;
        display: flex;
        flex-direction: column;
    }

    h1 {
        text-align: center;
        color: #333;
        margin-bottom: 30px;
        font-size: 28px;
    }

    /* Draggable list styles */
    .content-list {
        list-style-type: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .content-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #f9f9f9;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        cursor: grab;
        transition: transform 0.2s ease;
    }

    .content-item:hover {
        background-color: #f1f1f1;
        transform: scale(1.02);
    }

    .save-btn {
        background-color: #007bff;
        color: white;
        padding: 12px 30px;
        font-size: 18px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        margin: 30px auto 0;
        display: block;
        transition: background-color 0.3s ease;
    }

    .save-btn:hover {
        background-color: #0056b3;
    }
.input-container {
    width: 50%;
    background-color: #fff;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    padding: 30px;
    text-align: left;
    font-family: 'Arial', sans-serif;
}

.input-container h2 {
    font-size: 24px;
    margin-bottom: 20px;
    text-align: center;
    color: #333;
}

.input-container label {
    font-size: 16px;
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #333;
}

.input-container select,
.input-container input[type="text"] {
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-bottom: 20px;
    font-size: 16px;
    box-sizing: border-box;
}

.input-container textarea {
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 16px;
    resize: none;
    box-sizing: border-box;
}

.submit-button {
    padding: 12px 25px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 20px;
    display: block;
    width: 100%;
}

.submit-button:hover {
    background-color: #45a049;
}

hr {
    border: 0;
    border-top: 1px solid #eee;
    margin: 30px 0;
}

.tagline {
    padding: 30px;
    border: 1px solid #ccc;
    background-color: #f9f9f9;
    border-radius: 8px;
    text-align: center;
    font-size: 20px;
    color: white;
    white-space: nowrap; /* Prevent text from wrapping */
    overflow: hidden; /* Hide overflow */
    width: 100%; /* Full width */
    position: relative;
}

.tagline span {
    position: absolute;
    animation: moveTagline 10s linear infinite;


}

@keyframes moveTagline {
    0% {
        right: -100%; /* Start from right off-screen */
    }
    100% {
        right: 100%; /* End at right off-screen */
    }
}


    /* Responsive adjustments */
    @media (max-width: 768px) {
        .content-layout {
            flex-direction: column;
        }

        .content-container,
        .input-container {
            width: 100%;
        }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper w3-margin-bottom">
        <!-- Video Container -->
        <div class="video-container">
            <asp:Literal ID="videoContainer" runat="server"></asp:Literal>
        </div>

        <!-- Below the Video: Content and Input Containers -->
        <div class="content-layout">
            <!-- Content Container (Left) -->
            <div class="content-container w3-margin-bottom">
                <h1>Rearrange Content</h1>
                <ul id="contentList" class="content-list">
                    <asp:Literal ID="contentListHtml" runat="server" />
                </ul>
                <button type="button" class="save-btn" onclick="saveOrder()">Save Order</button>
                <div id="statusMessage" class="status-message"></div>
            </div>

            <!-- Input Container (Right) -->
          <div class="input-container">
    <h2>Tagline</h2>
    
    <label for="txtLargeInput">Add your tagline below:</label>
    <!-- Textbox for tagline input -->
    <asp:TextBox ID="txtLargeInput" runat="server" TextMode="MultiLine" Rows="5" Columns="60"></asp:TextBox><br />
    
    <label for="ddlFont">Font:</label>
    <asp:DropDownList ID="ddlFont" runat="server">
        <asp:ListItem Text="Arial" Value="Arial"></asp:ListItem>
        <asp:ListItem Text="Verdana" Value="Verdana"></asp:ListItem>
        <asp:ListItem Text="Times New Roman" Value="Times New Roman"></asp:ListItem>
    </asp:DropDownList><br />
    
    <label for="ddlBackgroundColor">Background Color:</label>
    <asp:DropDownList ID="ddlBackgroundColor" runat="server">
        <asp:ListItem Text="Red" Value="Red"></asp:ListItem>
        <asp:ListItem Text="Blue" Value="Teal"></asp:ListItem>
        <asp:ListItem Text="Green" Value="Green"></asp:ListItem>
    </asp:DropDownList><br />
    
    <label for="txtSpeed">Speed (ms):</label>
    <asp:TextBox ID="txtSpeed" runat="server" Text="1000"></asp:TextBox><br />
    
    <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
    
    <!-- Submit Button -->
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="submit-button" />
    
    <!-- Preview -->
    <hr />
    <h3>Preview:</h3>
   <div id="previewDiv" class="tagline">
    <span><asp:Label ID="lblPreview" runat="server"></asp:Label></span>
</div>

</div>
</div>
</div>


    <script type="text/javascript">
        let contentOrder = [];

        let currentIndex = 0;

        function scrollVideos(direction) {
            const slider = document.querySelector('.video-slider');
            const videoItems = document.querySelectorAll('.video-item');
            const totalItems = videoItems.length;

            slider.style.pointerEvents = "none"; // Disable interaction temporarily

            currentIndex += direction;

            if (currentIndex < 0) {
                currentIndex = 0;
            } else if (currentIndex >= totalItems) {
                currentIndex = totalItems - 1;
            }

            const margin = parseInt(getComputedStyle(videoItems[0]).marginRight) || 0;
            const offset = -currentIndex * (videoItems[0].offsetWidth + margin);

            slider.style.transform = `translateX(${offset}px)`;

            setTimeout(() => {
                slider.style.pointerEvents = "auto"; // Re-enable interaction
            }, 500); // Match the transition duration in CSS
        }


        document.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowLeft') {
                scrollVideos(-1);
            } else if (e.key === 'ArrowRight') {
                scrollVideos(1);
            }
        });

        // Initialize sortable list
        document.addEventListener('DOMContentLoaded', function () {
            const el = document.getElementById('contentList');
            new Sortable(el, {
                animation: 150, // Smooth dragging
                onEnd: function (evt) {
                    // Update the contentOrder array with the new order
                    contentOrder = Array.from(el.children).map(item => item.querySelector('input').value);
                }
            });
        });
        window.addEventListener('resize', () => {
            const videoItems = document.querySelectorAll('.video-item');
            const margin = parseInt(getComputedStyle(videoItems[0]).marginRight) || 0;
            const offset = -currentIndex * (videoItems[0].offsetWidth + margin);
            document.querySelector('.video-slider').style.transform = `translateX(${offset}px)`;
        });

        function saveOrder() {
            const statusMessage = document.getElementById('statusMessage');
            statusMessage.style.display = 'none'; // Reset status message visibility

            // Send the updated order to the server
            const order = contentOrder.join(',');
            const saveOrderUrl = 'RearrangeContent.aspx?order=' + order;

            fetch(saveOrderUrl, {
                method: 'GET'
            })
                .then(response => response.text())
                .then(result => {
                    statusMessage.style.display = 'block';
                    statusMessage.textContent = 'Order saved successfully!';
                    statusMessage.className = 'status-message success';
                })
                .catch(error => {
                    console.error('Error saving order:', error);
                    statusMessage.style.display = 'block';
                    statusMessage.textContent = 'Error saving order.';
                    statusMessage.className = 'status-message error';
                });
        }
    </script>
</asp:Content>
