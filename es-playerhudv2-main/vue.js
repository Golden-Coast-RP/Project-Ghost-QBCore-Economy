
const app = new Vue({
  el: '#app',
  data: {
    keybinds:[],
    user:[{id:"", bank:"", cash:"", online:"", date:"", time:""}],
   },
   methods: { 
    data(add){
      this.keybinds = add
    },
    close(){
      this.keybinds = ""
    },
    player(user){
      this.user = user
    }  
  },
  
  })
  
  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.action === "help") {
        app.data(item.data);
       setTimeout(() => {
          app.close()
      }, 6000)
    }
    if (item.action == "player"){
      app.player(item.info)
    }

    })
