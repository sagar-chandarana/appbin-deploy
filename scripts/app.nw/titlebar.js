function closeWindow() {
window.close()
}

function updateImageUrl(image_id, new_image_url) {
  var image = document.getElementById(image_id);
  if (image)
    image.src = new_image_url;
}

function createImage(image_id, image_url) {
  var image = document.createElement("img");
  image.setAttribute("id", image_id);
  image.src = image_url;
  return image;
}

function createButton(button_id, button_name, normal_image_url,
                       hover_image_url, disable_image_url, click_func, state) {
  var button = document.createElement("div");
  button.setAttribute("class", button_name);
  button.disabled = state;
  var button_img = createImage(button_id, normal_image_url);
  button.appendChild(button_img);
  if (button.disabled == false) {
  
      button.onmouseover = function() {
          updateImageUrl(button_id, hover_image_url);
        }
      button.onmouseout = function() {
          updateImageUrl(button_id, normal_image_url);
        }
		button.onclick = click_func;
	}

  
  return button;
}

function focusTitlebars(focus) {
  var bg_color =  "#3a3d3d";
    
  var titlebar = document.getElementById("top-titlebar");
  
 
}


function addTitlebar(titlebar_name, titlebar_icon_url, titlebar_text,state) {
  var titlebar = document.createElement("div");
  titlebar.setAttribute("id", titlebar_name);
  titlebar.setAttribute("class", titlebar_name);

  var icon = document.createElement("div");
  icon.setAttribute("class", titlebar_name + "-icon");
  icon.appendChild(createImage(titlebar_name + "icon", titlebar_icon_url));
  titlebar.appendChild(icon);

  var title = document.createElement("div");
  title.setAttribute("class", titlebar_name + "-text");
  title.innerText = titlebar_text;
  titlebar.appendChild(title);

  var closeButton = createButton(titlebar_name + "-close-button",
                                 titlebar_name + "-close-button",
                                 "button_close.png",
                                 "button_close_hover.png",
								 "appbin_icon.png",
                                 closeWindow,state);
   
  titlebar.appendChild(closeButton);

  var divider = document.createElement("div");
  divider.setAttribute("class", titlebar_name + "-divider");
  titlebar.appendChild(divider);
  
  document.body.appendChild(titlebar);
}


function removeTitlebar(titlebar_name) {
  var titlebar = document.getElementById(titlebar_name);
  if (titlebar)
    document.body.removeChild(titlebar);
}


function updateContentStyle() {
  var content = document.getElementById("content");
  if (!content)
    return;

  var left = 0;
  var top = 0;
  var width = window.outerWidth;
  var height = window.outerHeight;

  var titlebar = document.getElementById("top-titlebar");
  if (titlebar) {
    height -= titlebar.offsetHeight;
    top += titlebar.offsetHeight;
  }
  titlebar = document.getElementById("bottom-titlebar");
  if (titlebar) {
    height -= titlebar.offsetHeight;
  }
  titlebar = document.getElementById("left-titlebar");
  if (titlebar) {
    width -= titlebar.offsetWidth;
    left += titlebar.offsetWidth;
  }
  titlebar = document.getElementById("right-titlebar");
  if (titlebar) {
    width -= titlebar.offsetWidth;
  }

  var contentStyle = "position: absolute; ";
  contentStyle += "left: " + left + "px; ";
  contentStyle += "top: " + top + "px; ";
  contentStyle += "width: " + width + "px; ";
  contentStyle += "height: " + height + "px; ";
  content.setAttribute("style", contentStyle);
}

