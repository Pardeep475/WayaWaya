(function () {

    angular.module('TwoDMap', ["ngMaterial", "ngSelect"])
        .config(function ($mdIconProvider) {
            $mdIconProvider
                .iconSet("call", 'img/icons/sets/ic_business_black_24px.svg', 24)
                ;
        })
        .filter('categoryRemovefilter', function () {
            return function (items, condition) {
                // console.log("categoryRemovefilter",items, condition)
               
                var filtered = [];

                if (condition === undefined || condition === '') {
                    return items;
                }

                angular.forEach(items, function (item) {
                    var re = new RegExp('^assets', 'ig')
                    if (( condition !== item.type || item.type === '') ) {
                        if(re.test(item.name.replace(' ','').toLowerCase()) === false){
                            // console.log(!re.test(item.name.replace(' ','').toLowerCase()), re.test(item.name.replace(' ','').toLowerCase()) )
                            // console.log(item.name.replace(' ','').toLowerCase())
                            filtered.push(item);
                        }
                    }
                });

                return filtered;
            };
        })
        .filter('categoryfilter', function () {
            return function (items, condition) {
                // console.log("categoryfilter",items, condition)
                var filtered = [];

                if (condition === undefined || condition === '') {
                    return items;
                }
                var re = new RegExp('^assets', 'ig')
                angular.forEach(items, function (item) {
                    if (condition === item.type || item.type === '') {
                        // console.log(re.test(item.name.replace(' ','').toLowerCase()), item.name.replace(' ','').toLowerCase()) 
                        if(!re.test(item.name.replace(' ','').toLowerCase())){
                         filtered.push(item);
                        }
                    }
                });

                return filtered;
            };
        })
        .directive('twoDMap', function ($window) {
            /* stuff here */
            // console.log("Directive");
            // // console.log('inside directive', jvectormap());
            var category_selection = false;
            function localController($scope, $element, $attrs, $mdSidenav, $log, $timeout) {
                var vm = this;
                $scope.showLoader = true;
                // for transation
                vm.getTranslated = '';
                var mapObj = {};
                var mapInfo = $scope.mapInfo;
                var initialMapData = {};
                // // console.log($scope.mapInfo);
                $scope.floorSelection = { "building": $scope.building, "floor": $scope.floor };
                $scope.categoryParent = {};
                $scope.categoryParent.selection = $scope.building;
                $scope.selectedCategory = undefined; //$scope.category;
                // $scope.selectRegionsBasedOnCategories = [];
                // $scope.categorySelection = '';
                $scope.services = "services";
                var customTip=$('#customTip');
                var shopName=$('#shopName');
                customTip.hide();
                shopName.hide();

                function jvectormap($element, name, data, regions, selectedRegions, mapobject, x, y) {
                    $($element).find(".vmap").html('');
                    var showShopNamesOnMap = false;

                    jQuery.fn.vectorMap('addMap', name, data);
                    setTimeout(function () {
                        // console.log("Map", name, data);

                        $($element).find(".vmap").vectorMap(mapobject);

                        mapObj = $($element).find(".vmap").vectorMap('get', 'mapObject');

                        if (angular.isDefined(x) && angular.isDefined(y)) {
                            mapObj.transX = x;
                            mapObj.transY = y;
                            mapObj.applyTransform();
                        }
                        // mapObj.container.mousemove(function(e) {
                        //     // console.log("Position", e.pageX, e.pageY);
                        //     $scope.left = e.pageX - 40;
                        //     $scope.top = e.pageY - 60;
                        // });
                        mapObj.clearSelectedRegions();
                        mapObj.setSelectedRegions(selectedRegions);

                    }, 20);

                    var height = $window.innerHeight;
                    var width = $window.innerWidth;
                    var mapViewHeight = 0.72 * height;
                    $($element).find(".vmap").height(mapViewHeight);
                }

                $scope.$watchGroup(['mapInfo', 'building', 'floor'], function (newAa, oldAa) {
                    // console.log('inside outside', newAa, oldAa);
                    if ((typeof newAa[0] != "undefined" && typeof newAa[1] != "undefined" && typeof oldAa[2] != "undefined")) {
                        $scope.showLoader = false;
                        // console.log("FLoor slection in module", $scope.categoryParent.selection, $scope.floorSelection);
                        $scope.categoryParent.selection = newAa[1];
                        $scope.floorSelection = { "building": $scope.building, "floor": newAa[2] };
                        updateMap();
                        // mapObj = $($element).find(".vmap").vectorMap('get', 'mapObject');

                    }

                });

                // console.log("Hello", "World", vm);

                // jvectormap($element, name, data, regions, selectedRegions);

                $scope.isCloseMobile = false;

                function updateMap() {

                    // // console.log('test', $scope.mapInfo, $scope.categoryParent.selection,$scope.floorSelection);
                    // console.log('inside watch', $scope.mapInfo);

                    $scope.currrenBuilding = $scope.mapInfo[$scope.categoryParent.selection];
                    // console.log('$scope.mapInfo[$scope.categoryParent.selection]', $scope.currrenBuilding);
                    // console.log('$scope.floorSelection ', $scope.floorSelection);
                    $scope.currrenFloor = $scope.mapInfo[$scope.floorSelection.building][$scope.floorSelection.floor];

                    var floors = [];
                    var i = 1;
                    for (var k in $scope.mapInfo[$scope.categoryParent.selection]) {
                        
                        if (k.indexOf("F") != -1 && $scope.mapInfo[$scope.categoryParent.selection][ k]) {
                            // console.log("---",k, $scope.mapInfo[$scope.categoryParent.selection]['F' + i].title,i )
                            var buildingFloor = { "building": $scope.categoryParent.selection, "floor": k };
                            floors.push({ "key": buildingFloor, "title": $scope.mapInfo[$scope.categoryParent.selection][ k].title });
                            i++;
                        }
                    }



                    $scope.floors = floors;


                    $scope.hidden = false;
                    $scope.isOpen = false;
                    $scope.labelShown = false;
                    $scope.labelHidden = true;
                    //$scope.hover = false;

                    // On opening, add a delayed property which shows tooltips after the speed dial has opened
                    // so that they have the proper position; if closing, immediately hide the tooltips
                    $scope.$watch('isOpen', function (isOpen) {
                        if (isOpen) {
                            $timeout(function () {
                                $scope.tooltipVisible = $scope.isOpen;
                            }, 200);
                        } else {
                            $scope.tooltipVisible = $scope.isOpen;
                        }
                    });

                    $scope.items = [
                        { icon: "wc", direction: "top" }
                        // { name: "Landmark", icon: "place", direction: "top" },
                        // { name: "Parking", icon: "local_parking", direction: "bottom" }
                    ];

                    var name = $scope.currrenFloor.name;
                    var data = $scope.currrenFloor.mData;
                    var regions = $scope.currrenFloor.regions;
                    // console.log('regions in update map', regions);
                    var selectedRegions = $scope.currrenFloor.selectedRegions ? $scope.currrenFloor.selectedRegions : [];
                    $scope.categories = $scope.currrenFloor.categories ? $scope.currrenFloor.categories : [];

                    var removeMapOpacityTimer = '';
                    $scope.onSelect = function (event, label, isSelected, selectedRegions) {
                        // var customTip=$('#customTip');
                        // var shopName=$('#shopName');
                        // customTip.removeClass("pin");
                        // // console.log('On Region customTip', customTip);
                        // console.log('On Select regions', selectedRegions, $scope.selectRegionsBasedOnCategories);
                        customTip.hide();
                        shopName.hide();
                        // var isActive = !!$('.c-services span[ng-select-option="category.name"].active').length
                        // if (isActive) {
                        //     updateCategories(null, 20);
                        // }
                        $timeout.cancel(removeMapOpacityTimer);
                        removeMapOpacityTimer = $timeout(function () {
                            // updateCategories('', 20);
                            // var temp = angular.copy(initialMapData);
                            // temp.regionStyle.initial['fill-opacity'] = 1;
                            // var name = $scope.currrenFloor.name;
                            // var data = $scope.currrenFloor.mData;
                            // var regions = $scope.currrenFloor.regions;
                            // jvectormap($element, name, data, regions, [], temp);
                            if (selectedRegions.length === 1 && isSelected) {
                                var map = $('.vmap').vectorMap('get', 'mapObject');
                                // var element = map.regions[selectedRegions[0]].element;
                                // map.params.regionStyle.initial['fill-opacity'] = 1;
                                // map.applyTransform();
                                if ($scope.selectRegionsBasedOnCategories[0] !== selectedRegions[0]) {
                                    $('[fill-opacity="0.3"]').attr('fill-opacity', 1);
                                    map.params.regionStyle.hover["fill-opacity"] = 1;
                                    var element = map.regions[label].element;
                                    bbox = element.shape.getBBox();
                                    xcoord = (((bbox.x + bbox.width / 2) + map.transX) * map.scale);
                                    ycoord = (((bbox.y + bbox.height / 2) + map.transY) * map.scale) - 64;
                                    // // console.log('On Region Click', xcoord, ycoord);

                                    customTip.addClass("pin");
                                    // shopName.addClass("pin");
                                    customTip.css({
                                        left: xcoord,
                                        top: ycoord + 40,
                                    });
                                    shopName.css({
                                        left: xcoord - 20,
                                        top: ycoord - 20,
                                    });
                                    customTip.html();
                                    customTip.show();
                                    var toolTipTxt = map.getRegionName(label);
                                    shopName.html(toolTipTxt);
                                    // shopName.append("<br/>" + label);
                                    if (toolTipTxt.length > 0) {
                                        setTimeout(function () {
                                            shopName.show();
                                        }, 0)
                                    }
                                    $scope.selectedCategory = '';
                                }
                                
                            }
                        }, 20);
                    };
                    initialMapData = {
                        map: name,
                        backgroundColor: 'transparent',
                        // focusOn: {
                        //     scale: 1,
                        //     // region: ''
                        //     x: 0,
                        //     y: 0,
                        //     animate: true
                        // },
                        regionStyle: {
                            initial: {
                                fill: 'white',
                                "fill-opacity": 0.9,
                                stroke: 'none',
                                'stroke-width': 0,
                                'stroke-opacity': 1
                                // cursor: 'default',
                            },
                            hover: {
                                "fill-opacity": 0.6,
                                cursor: 'pointer'
                            },
                            selected: {
                                fill: '#3CB6B5',
                                'fill-opacity': 1
                            },
                            selectedHover: {
                            }
                        },
                        regionsSelectable: true,
                        regionsSelectableOne: true,
                        zoomButtons: true,
                        series: {
                            regions: regions,
                        },
                        regionLabelStyle: {
                            initial: {
                                'fill': 'transparent',
                                'font-family': 'Verdana',
                                'font-size': '12',
                                'font-weight': 'normal',
                            },
                            selected: {
                                fill: 'transparent',
                                'fill-opacity': 1
                            },
                            hover: {
                                fill: 'transparent'
                            }
                        },
                        labels: {
                            regions: {
                                render: function (code) {
                                    if (angular.isDefined(data.paths[code]) && angular.isDefined(data.paths[code].shortname)) {
                                        return data.paths[code].shortname;
                                    }
                                    else if (angular.isDefined(data.paths[code]) && angular.isDefined(data.paths[code].name)) {
                                        return data.paths[code].name;
                                    }
                                },
                                // offsets: function(code){
                                //     // if(true && code.indexOf("P") != -1 || code.indexOf("id") != -1 ){
                                //  //     return data["paths"][code]["name"]
                                //     // }
                                //     return true
                                // }
                            }
                        },
                        // onRegionTipShow: function (e, el, code) {
                        //     // // console.log("on zoom in map", e, code);
                        //     if (el.html() === '') {
                        //         e.preventDefault();
                        //     }
                        // },
                        onViewportChange: function (e, scale) {
                            // // console.log("scale condition greater", scale, scale > 2.50);
                            // // console.log("scale condition less", scale, scale < 2.50);
                            // $scope.labelShown = true;
                            if (scale > 8) {
                                console.log("Show");
                                showShopLabels(parseFloat(scale).toFixed(2));
                            }
                            else if (scale < 3.50 && scale !== 1) {
                                hideShopLabels(parseFloat(scale).toFixed(2));
                            }
                        },
                        onRegionTipShow: function (event, label, code) {
                            // $(label).append($("<br/>"));
                            // if (el.html() === '') {
                            //     e.preventDefault();
                            // }
                            event.preventDefault();
                            // $(label).append($("<span/>", {
                            //     'class': 'pin',
                            //     // 'html': '<p>' + label + '<p>'
                            // }));
                        },
                        // onRegionSelected: function (event, label, isSelected, selectedRegions) {
                        //     // $(label).append($("<br/>"));
                        //     // if (el.html() === '') {
                        //     //     e.preventDefault();
                        //     // }
                        //     var customTip=$('#customTip');
                        //     var shopName=$('#shopName');
                        //     // customTip.removeClass("pin");
                        //     customTip.hide();
                        //     shopName.hide();
                        //     if (selectedRegions.length === 1 && isSelected) {
                        //         var map = $('.vmap').vectorMap('get', 'mapObject');
                        //         // console.log('On Region Click', $scope.left, $scope.top);
                        //         // console.log('On Region customTip', customTip);
                        //         // console.log('On Region shopName', shopName);
                        //         customTip.addClass("pin");
                        //         // shopName.addClass("pin");
                        //         customTip.css({
                        //             left: $scope.left,
                        //             top: $scope.top
                        //         });
                        //         shopName.css({
                        //             left: $scope.left,
                        //             top: $scope.top,
                        //         });
                        //         customTip.html();
                        //         customTip.show();
                        //         shopName.html(map.tip.text());
                        //         // shopName.append("<br/>" + label);
                        //         shopName.show();
                        //     }
                        // }
                    };
                    var hidelist = ["Hide", "Leisure", "Grass", "Stilt", "Hallway", "Invisible", "Other"];
                    $scope.$watch("categoryParent.selection", function (newA, oldA) {
                        // console.log("Selection", newA, oldA, $scope.categoryParent.selection);
                        // // console.log("Building", $scope.categoryParent.selection, newA, oldA, $scope.mapInfo[newA][$scope.floorSelection.floor]);
                        customTip.hide();
                        shopName.hide();
                        if (newA !== undefined) {
                            // console.log('Check Building', typeof newA);
                            if (typeof newA == "string") {
                                $scope.currrenFloor = $scope.mapInfo[newA][$scope.floorSelection.floor];
                                name = $scope.currrenFloor.name;
                                data = $scope.currrenFloor.mData;
                                regions = $scope.currrenFloor.regions;
                                selectedRegions = $scope.currrenFloor.selectedRegions ? $scope.currrenFloor.selectedRegions : [];
                                $scope.categories = [];
                                // console.log('Test', regions);
                                // console.log("CATEGORIES ", $scope.categories);
                                for (var i in $scope.currrenFloor.categories) {
                                    // if ($scope.currrenFloor.categories[i].icon !== 'hide' && $scope.currrenFloor.categories[i].icon !== 'beach_access') {
                                    //     // console.log($scope.currrenFloor.categories[i]);
                                    //     $scope.categories.push($scope.currrenFloor.categories[i]);
                                    // }

                                    if (!hidelist.includes($scope.currrenFloor.categories[i].name)) {
                                        // console.log($scope.currrenFloor.categories[i]);
                                        $scope.categories.push($scope.currrenFloor.categories[i]);
                                    }
                                }

                                regions[0].legend = {
                                    cssClass: 'legend',
                                    vertical: true,
                                    title: 'Categories'
                                };
                                initialMapData.series.regions = regions;
                                initialMapData.onRegionSelected = $scope.onSelect;
                                // console.log('Selected Retail Unit ', selectedRegions, $scope.currrenFloor.selectedRegions);
                                if (selectedRegions.length === 1) {
                                    initialMapData.focusOn = {
                                        'region': selectedRegions[0],
                                        'scale': 1,
                                        'x': 1,
                                        'y': 1,
                                        'animate': true
                                    };
                                }
                                jvectormap($element, name, data, regions, selectedRegions, initialMapData);
                            } else if (newA instanceof Object) {
                                // console.log("Building", newA, $scope.mapInfo);
                                $scope.currrenFloor = $scope.mapInfo[newA.building][newA.floor];
                                name = $scope.currrenFloor.name;
                                data = $scope.currrenFloor.mData;
                                regions = $scope.currrenFloor.regions;
                                selectedRegions = $scope.currrenFloor.selectedRegions ? $scope.currrenFloor.selectedRegions : [];
                                $scope.categories = $scope.currrenFloor.categories ? $scope.currrenFloor.categories : [];
                                // console.log('Map data', regions, data);
                                regions[0].legend = {
                                    cssClass: 'legend',
                                    vertical: true,
                                    title: 'Categories'
                                };
                                initialMapData.series.regions = regions;
                                initialMapData.focusOn = {
                                    'scale': 1,
                                    'x': 0,
                                    'y': 0,
                                    'animate': true
                                };
                                // jvectormap($element, name, data, regions, selectedRegions, initialMapData);
                                updateCategories($scope.selectedCategory, 200);
                                // $scope.categoryParent.categorySelection = $scope.selectedCategory;
                            }
                            $scope.currrenFloor.selectedRegions = [];
                            // $scope.floors = $scope.buildings[$scope.categoryParent.selection]["floors"];

                        }
                    });
                    $scope.$watch('category', function(newA, oldA){
                            console.log("Watch category", newA, oldA);
                            $scope.categoryParent.categorySelection = newA; 
                            // category_selection = (newA != undefined )?true:false;
                            // updateCategories($scope.category, 200);
                    });
                    
                    $scope.$watch('categoryParent.categorySelection', function (newA, oldA) {
                        console.log("Hello", newA, oldA, $scope.categoryParent.categorySelection);
                        // var isActive = !!$('.c-services span[ng-select-option="category.name"].active').length
                        // $scope.selectedCategory = $scope.selectedCategory === newA ? '' : newA;
                        if ($scope.selectedCategory === newA) {
                            $scope.selectedCategory = '';
                            $scope.categoryParent.categorySelection = '';
                            $('.c-services span.active').removeClass('active');
                        } else {
                            $scope.selectedCategory = newA;
                        }
                        // if (prevSelection !== isActive) {
                        updateCategories($scope.selectedCategory, 200);
                        // if (newA) {
                        //     updateCategories(newA, 200);
                        // }
                        // else {
                        //     updateCategories($scope.selectedCategory, 200);
                        // }
                    });
                    var debounce = '';
                    function updateCategories(newA, timeout) {
                        if (!debounce) {
                            debounce = $timeout(function () {
                                $scope.selectedCategory = newA;
                                console.log("updateCategories", newA, category_selection, $scope.currrenFloor);
                                var clearSelectedRegions = false;
                                $scope.selectRegionsBasedOnCategories = [];
                                if ($scope.currrenFloor.regions.length > 0) {
                                    angular.forEach($scope.currrenFloor.regions[0].values, function (value, key) {
                                        // console.log("Category ", newA, value, key);
                                        if (newA == value) {
                                            this.push(key);
                                        }
                                        else {
                                            clearSelectedRegions = true;
                                        }

                                    }, $scope.selectRegionsBasedOnCategories);

                                    if ($scope.selectRegionsBasedOnCategories.length == 0 && newA != undefined) {
                                        // $scope.building = 'B1';
                                        // $scope.floor = 'F1';
                                        // $scope.category = newA;
                                        // $scope.categoryParent.categorySelection = newA;
                                    }

                                    console.log("Selected Categories", $scope.selectRegionsBasedOnCategories, $scope.mapInfo);
                                    // }
                                }
                                setTimeout(function () {
                                    // console.log('set time', "A", initialMapData);
                                    // console.log('Clear Selected Regions ', mapObj);
                                    // if (clearSelectedRegions && angular.isDefined(mapObj.clearSelectedRegions)) {
                                    //     mapObj.clearSelectedRegions();
                                    // }
                                    // console.log('Selected Regions ', $scope.selectRegionsBasedOnCategories, initialMapData);
                                    // mapObj = $($element).find(".vmap").vectorMap('get', 'mapObject');
                                    if ($scope.selectRegionsBasedOnCategories.length !== 0) {
                                        var temp = angular.copy(initialMapData);
                                        temp.regionStyle.initial['fill-opacity'] = 0.3;
                                        jvectormap($element, name, data, regions, $scope.selectRegionsBasedOnCategories, temp);
                                        // mapObj.setSelectedRegions($scope.selectRegionsBasedOnCategories);
                                    }
                                    else {
                                        jvectormap($element, name, data, regions, $scope.selectRegionsBasedOnCategories, initialMapData);
                                    }
                                    // $timeout(function () {
                                    //     $('.c-services span[ng-select-option="category.name"]').mousedown(function (e) {
                                    //         console.log(e);
                                    //     })
                                    // },0)
                                }, timeout)
                                debounce = '';
                            }, 20)
                        }
                    }



                    function getCurrentCenter() {
                        // mapObj = $($element).find(".vmap").vectorMap('get', 'mapObject');
                        return [mapObj.transX, mapObj.transY];
                    }

                    function showShopLabels(scale) {
                        if (!$scope.labelShown) {
                            // console.log("Show labels", initialMapData.focusOn);
                            var centerCoordinates = getCurrentCenter();
                            initialMapData.regionLabelStyle.initial.fill = "#000000";
                            initialMapData.focusOn = {
                                'scale': scale,
                                'x': 0,
                                'y': 0,
                            };
                            jvectormap($element, name, data, regions, selectedRegions, initialMapData, centerCoordinates[0], centerCoordinates[1]);
                            $scope.labelShown = true;
                            $scope.labelHidden = false;
                        }
                    }

                    function hideShopLabels(scale) {
                        // // console.log('$scope.labelHidden', !$scope.labelHidden && $scope.labelShown);
                        if (!$scope.labelHidden && $scope.labelShown) {
                            // console.log("Hide labels", initialMapData.focusOn.region);
                            if (angular.isUndefined(initialMapData.focusOn.regio)) {
                                selectedRegions = [];
                                customTip.hide();
                                shopName.hide();
                            }
                            var centerCoordinates = getCurrentCenter();
                            initialMapData.regionLabelStyle.initial.fill = "transparent";
                            initialMapData.focusOn = {
                                'scale': scale,
                                'x': 0,
                                'y': 0,
                            };
                            jvectormap($element, name, data, regions, selectedRegions, initialMapData, centerCoordinates[0], centerCoordinates[1]);
                            $scope.labelShown = false;
                            $scope.labelHidden = true;
                        }
                    }


                }   //eof

            }


            return {
                restrict: 'E',
                scope: {
                    'mapInfo': '=', 'selected-regions': '=', 'building': '=', 'floor': '=', 'category': '='
                },
                // template: '<div layout="row" class="mall-map" ><div class="vmap" layout="column" class="zero" ></div><div class="toolbar"><md-button> Button </md-button></div></div>',
                template: '<div id="customTip" class=""></div>' +
                '<div id="shopName" ></div>' +
                '<div class="container" ng-if="showLoader"><div class="loader"></div></div>' +
                '<div layout-fill layout="row" id="twod_map_container" ng-if="!showLoader" >' +
                '' +
                '  <section layout="row" flex layout-fill>' +
                '' +
                '    <md-content flex layout-fill>' +
                '' +

                '      <div layout-fill  class="vmap" >' +
                '      </div>' +
                '<md-toolbar class="twod-toolbar-height">' +

                '    <md-fab-speed-dial ng-hide="hidden" md-close="isOpen" md-direction="up" class="md-scale twod-bld-speeddial" ng-class="{ \'md-hover-full\': hover }" ng-mouseenter="isOpen=true" ng-mouseleave="isOpen=false" style="align-items: flex-end;">' +
                '      <md-fab-trigger>' +
                '        <md-button aria-label="menu" class="md-fab md-primary">' +
                '            <md-tooltip md-direction="left">Menu</md-tooltip>' +
                // '            <i class="material-icons material-icons-i" >business</i>' +
                '                <i class="mdi mdi-24px mdi-domain"></i>' +
                '        </md-button>' +
                '      </md-fab-trigger>' +

                '      <md-fab-actions>' +
                '       <div class="item" ng-select ng-model="categoryParent.selection">' +
                '           <span  select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}" class="active" select-multiple=""  layout-align="space-around center" ng-repeat="(index, building) in mapInfo" class="md-item-text " ng-select-option="index" select-class="{\'selected\': $optSelected}" flex>' +
                '    <md-fab-speed-dial ng-hide="hidden" md-open="isOpen" md-direction="left" class="md-scale" ng-class="{ \'md-hover-full\': hover }" ng-mouseenter="isOpen=true" ng-mouseleave="isOpen=false">' +
                '      <md-fab-trigger>' +
                '               <md-button aria-label="menu" class="md-fab md-primary">' +
                '                 <md-tooltip md-direction="top">Building</md-tooltip>' +
                // '                 <i  class="material-icons material-icons-i">business</i>' +
                '                <i class="mdi mdi-24px mdi-domain"></i>' +
                '               <span class="b-name">{{building.name[0].text| limitTo : 3 : 0}}</span>' +
                '               </md-button>' +
                '      </md-fab-trigger>' +

                '      <md-fab-actions>' +
                // '      <div class="item" ng-select ng-model="floorSelection" >'+
                '           <md-button class="md-fab md-raised md-mini md-primary" select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}"  select-multiple="" layout-align="space-around center" ng-repeat="(floorIndex, floor) in floors" class="md-item-text " ng-select-option="floor.key" select-class="{\'selected\': $optSelected}" flex>' +
                '                   <md-tooltip md-direction="{{item.direction}}" md-autohide="false">' +
                '                       {{floor.title[0].text}}' +
                '                   </md-tooltip>' +
                // '              <i class="material-icons material-icons-i" >layers</i>' +
                '                <i class="mdi mdi-24px mdi-layers"></i>' +
                '<span class="b-name">{{floor.key.floor}}</span>' +
                // '                <p class="icon-text-gap">{{floor.title[0].text}}</p>'+
                '           </md-button>' +
                // '     </div>'+
                '      </md-fab-actions>' +
                '    </md-fab-speed-dial>' +
                '           </span >' +
                '       </div>' +
                '      </md-fab-actions>' +
                '    </md-fab-speed-dial>' +//eot1
                //

                // '    <md-fab-speed-dial ng-hide="hidden" md-open="isClose" md-direction="up" class="md-scale twod-f-speeddial" ng-class="{ \'md-hover-full\': hover }" ng-mouseenter="isOpen=true" ng-mouseleave="isOpen=false" style="align-items: flex-start;">' +
                // // '      <md-fab-trigger>' +
                // // '        <md-button aria-label="menu" class="md-fab material-icons-i-colr">' +
                // // '            <md-tooltip md-direction="right">Services</md-tooltip>' +
                // // '            <i class="material-icons material-icons-i" >local_laundry_service</i>' +
                // // '        </md-button>' +
                // // '      </md-fab-trigger>' +

                // '      <md-fab-actions>' +
                // '   <span ng-select class="item"  ng-model="categoryParent.categorySelection" >' +
                // // '      <md-subheader class="md-no-sticky" >Services</md-subheader >'+
                // '       <span ng-select-option="category.name" md-open="isClose" select-multiple="" ng-repeat="(index, category) in categories|categoryfilter:services" >' +
                // '    <md-button select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}" class="md-fab md-mini md-primary" aria-label="Use Android">' +
                // '               <md-tooltip md-direction="{{item.direction}}" md-autohide="false">' +
                // '                       {{category.name}}' +
                // '               </md-tooltip>' +
                // '        <i  class="material-icons  md-avatar material-icons-i">{{category.icon}}</i>' +
                // '        </md-button>' +
                // '        </span>' +
                // '  </span>' +

                // '      </md-fab-actions>' +
                // '    </md-fab-speed-dial>' +//eot2

                '    <md-fab-speed-dial md-open="isCloseMobile" md-direction="up" class="md-scale twod-fb-speeddial" ng-class="{ \'md-hover-full\': hover }" ng-mouseenter="isOpen=true" ng-mouseleave="isOpen=false" style="align-items: flex-start;">' +
                '      <md-fab-trigger>' +
                '        <md-button aria-label="menu" class="md-fab md-primary">' +
                '            <md-tooltip md-direction="right">Category</md-tooltip>' +
                // '            <i class="material-icons material-icons-i" >shop</i>' +
                '                <i class="mdi mdi-24px mdi-shopping-search"></i>' +
                '        </md-button>' +
                '      </md-fab-trigger>' +

                '      <md-fab-actions>' +
                '        <span ng-select class="item"  ng-model="categoryParent.categorySelection">' +
                '           <span ng-select-option="category.name" select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}" select-multiple="" ng-repeat="(index, category) in categories|categoryRemovefilter:services" >' +
                '            <md-button select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}" class="md-fab md-mini custom-icon-btn" aria-label="Use Android">' +
                '               <md-tooltip md-direction="{{item.direction}}" md-autohide="false">' +
                '                       {{category.name}}' +
                '               </md-tooltip>' +
                // '               <i  class="material-icons md-avatar material-icons-i" >{{category.icon}}</i>' +
                // '                   <i class="mdi mdi-24px mdi-{{category.icon}}"></i>' +
                // '               <img src="../../icons/Category Icons-01.png" class="custom-icon-img"></img>' +
                // '                   <md-icon  class="custom-icon-img" md-svg-src="../../icons/{{category.icon}}.svg"></md-icon>' +
                '               <md-icon class="custom-icon-img"><i ng-class="[\'icon-\' + category.icon]"></i></md-icon>' +
                '            </md-button>' +
                // '          <h3>{{category.name}}</h3>'+
                // '          <p>{{category.type}}</p>'+
                '            </span>' +
                '        </span>' +
                '      </md-fab-actions>' +
                '    </md-fab-speed-dial>' +//eot3
                '<div class="c-services">' +
                '   <span ng-select class="item inside-c-services"  ng-model="categoryParent.categorySelection" >' +
                // '      <md-subheader class="md-no-sticky" >Services</md-subheader >'+
                '       <span ng-select-option="category.name"  select-multiple="" ng-repeat="(index, category) in categories|categoryfilter:services" >' +
                '    <md-button select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}" class="md-fab md-mini custom-icon-btn" aria-label="Use Android">' +
                '               <md-tooltip md-direction="{{item.direction}}" md-autohide="false">' +
                '                       {{category.name}}' +
                '               </md-tooltip>' +
                // '        <i  class="material-icons  md-avatar material-icons-i">{{category.icon}}</i>' +
                '                   <i class="mdi mdi-24px mdi-{{category.icon}}"></i>' +
                '        </md-button>' +
                '        </span>' +
                '  </span>' +
                '   <span ng-select class="item cf-services"  ng-model="categoryParent.categorySelection">' +
                '       <span ng-select-option="category.name" select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}" select-multiple="" ng-repeat="(index, category) in categories|categoryRemovefilter:services" >' +
                '    <md-button select-class="{\'active\': $optSelected, \'no-hover\': makeDisabled}" class="md-fab md-mini custom-icon-btn" aria-label="Use Android">' +
                '               <md-tooltip md-direction="{{item.direction}}" md-autohide="false">' +
                '                       {{category.name}}' +
                '               </md-tooltip>' +
                // '<i  class="material-icons md-avatar material-icons-i" >{{category.icon}}</i>' +
                '                   <md-icon class="custom-icon-img"><i ng-class="[\'icon-\' + category.icon]"></i></md-icon>' +
                // '                   <object class="custom-icon-img" type="image/svg+xml" data="../../icons/{{category.icon}}.svg"></object>' +
                // '               <img src="../../icons/Category Icons-01.png" class="custom-icon-img"></img>' +
                '        </md-button>' +
                // '          <h3>{{category.name}}</h3>'+
                // '          <p>{{category.type}}</p>'+
                '        </span>' +
                ' </span>' +
                ' </div>' +
                '  </md-toolbar>' +
                '    </md-content>' +
                '' +
                '' +
                '  </section>' +
                '' +
                '</div>',
                controller: localController
            };

        });
})();
