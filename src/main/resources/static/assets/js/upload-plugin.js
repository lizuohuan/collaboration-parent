/**
 *魔豆互动图片上传插件
 **/
(function ($) {
    $.fn.extend({
        uploadFile : function (options) {
            var $this = $(this);
            var settings = {
                imageService:null,
                path:'default',
                type: "other",
                title: "文件上传",
                isUpload: true,
                showPreview : false,
                showRemove: true,
                maxFileSize: 10240,
                allowedFileExtensions: ["jpg", "png", "jpeg","txt","xlsx","docx","rtf","doc","xls","ppt","html","htm","wpd","pdf","pptx","bmp","apk"],
                uploadUrl:"/upload/images",
                initialCaption: "请选择文件",
                maxCount: 1,
                data: [],
                callback: null
            };

            $.extend(settings, options);

            return this.each(function() {
                var $browserButton = $(this);

                $browserButton.click(function () {
                    var $dialog = bootbox.dialog({
                        message: content,
                        title: settings.title,
                        className: "modal-darkorange",

                        buttons: {
                            success: {
                                label: "确定",
                                className: "btn-blue",
                                callback: function () {
                                    if (settings.data.length == 0) {
                                        Notify.waring("还没有上传完成哦!");
                                        return false;
                                    }
                                    if (settings.showPreview) {
                                        if ($this.attr("type") == "text") {
                                            $this.val(settings.data[0].url);
                                        }
                                        var $view = $this.next();
                                        if ($view.hasClass("filePreview")) {
                                            $view.attr("href", settings.imageService + settings.data[0].url);
                                        } else {
                                            var $view = $("<a class='filePreview' style='position:relative;float: right; margin-top: -25px; margin-right: -30px;' target='_blank' href='" + settings.imageService + settings.data[0].url + "'>查看</a>")
                                            $view.insertAfter($this);
                                        }
                                    }
                                    if (settings.callback != null && typeof settings.callback == "function") {
                                        settings.callback(settings.data);
                                    }
                                }
                            },
                            "取消": {
                                className: "btn-danger",
                                callback: function () { }
                            }
                        }
                    });
                    $dialog.on("hidden.bs.modal", function () {
                        $.extend(settings, options);
                        settings.data = [];
                    });

                });

            });
            function content(){
                var html = '    <div class="row">'
                    + '<div class="col-md-12">'
                    +   '<div class="form-group">'
                    +       '<input type="file" name="file" id="uploadFile" class="form-control" placeholder="To" required="">'
                    +   '</div>'

                    +   '</div>'
                    + '</div>';
                html += '<div class="row">'
                    +   '<div class="col-md-12" id="fileContainer"></div>'
                    +  '</div>';
                // html = '<div style="width: 620px !important;">' + html + '</div>';
                var object = $('<div/>').html(html).contents();

                $upload = object.find('#uploadFile');
                var $fileContainer = object.find('#fileContainer');
                $upload.fileinput({
                    language:'zh',
                    uploadUrl: settings.imageService + settings.uploadUrl+"?file=file&path="+settings.path,
                    showPreview : false,
                    showRemove: false,
                    maxFileSize : settings.maxFileSize,  //上传图片的最大限制  50KB
                    allowedFileExtensions: settings.allowedFileExtensions,
                    initialCaption: settings.initialCaption,
                });
                $upload.on("fileuploaded", function (event, data, previewId, index) {
                    if (settings.data.length >= settings.maxCount) {
                        alert("达到最大限制, 无法上传");
                        return false;
                    }

                    if (null != data) {
                        console.log(data);
                        var fileType = data.files[0].type;
                        var fileName = data.files[0].name;
                        console.log(data.response.body[0]);
                        var file = data.response.body[0];
                        file.fileType = fileType;
                        file.fileName = fileName;
                        settings.data.push(file);

                        if (fileType.indexOf("image") >= 0) {
                            var priviewPath = file.sourcePath  + "?" + new Date().getTime();
                            if (file.smallPath) {
                                priviewPath = file.smallPath + "?" + new Date().getMilliseconds();
                            }
                            var imageHtml = '<div class="file-preview-item file-preview-frame file-preview-success" id="" data-fileindex="0" style="width: 110px;">'
                                + '<img src="' + settings.imageService + priviewPath + '" class="file-preview-image" style="width: 110px; height: 140px;">'
                                + '<div style=>'
                                +    '<span style="float: left;width: 80px;display:block;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">' + fileName +　'</span>'
                                +    '<button type="button" style="float: right" class="kv-file-remove btn btn-xs btn-default" title="删除文件"><i class="glyphicon glyphicon-trash text-danger"></i></button>'
                                + '</div>'
                                + '  </div>';
                            $fileContainer.append(imageHtml)
                        } else {
                            // $fileContainer.append('<span title="' + fileName + '" class="file-icon-4x"><i class="glyphicon glyphicon-file"></i></span>');
                            var otherHtml = '<div class="file-preview-item file-preview-frame"  style="width: 110px;">' +
                                '<div  style="width: 110px; height: 140px;">' +
                                '<span class="file-icon-4x" style="position: relative;top: 40px;">' +
                                '<i class="glyphicon glyphicon-file"></i>' +
                                '</span> ' +
                                '</div>'
                                + '<div style=>'
                                +    '<span style="float: left">' + fileName +　'</span>'
                                +    '<button type="button" style="float: right" class="kv-file-remove btn btn-xs btn-default" title="删除文件"><i class="glyphicon glyphicon-trash text-danger"></i></button>'
                                + '</div>'

                            '</div>';
                            $fileContainer.append(otherHtml);
                        }

                        $(".file-preview-item .kv-file-remove").unbind().click();
                        $(".file-preview-item .kv-file-remove").on("click", function () {
                            var $item = $(this).parents(".file-preview-item");
                            var index = $item.index();
                            $item.remove();

                            settings.data.remove(index);
                            console.log(settings.data);
                        });

                    } else {
                        Notify.danger("上传图片失败");
                    }

                });
                return object
            }

        }
    })
})(jQuery);