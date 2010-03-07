// XXX Refactor to elimate updateState (directly set upon action)
Module("block.ui.role", function () {
    Role("Editable", {
        requires: ["getText", "setText", "_updateStateCore", "touch", "_updateFromCore", "updateState"],
        after: {
            place: function () {
                var me = this;
                this.$.dblclick(function () {
                    var newValue = prompt("Please enter Text", me.textContainer().text())
                    if(newValue) {
                        me.text(newValue);
                        me.updateState()
                    }
                })
                
                me.text(this.getText())
            },
            
            _updateFromCore: function (shape) {
                this.text(shape.getText().decodeHtml())
            },
            
            _updateStateCore: function () {
                this.setText(this.textContainer().html());
            },
            
            redraw: function () {
                 this.textContainer().html(this.getText().decodeHtml())
            }
        },
        methods: {
            
            text: function (t) {
                if(arguments.length > 0) {
                	var html = new String(t).html();
                    this.textContainer().html(html)
                }
                return this.getText()
            },
            
            textContainer: function () {
                return this.$.find(".textField")
            }
        }
    })
})