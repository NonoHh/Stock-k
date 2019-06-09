var Kline = (function (stock_id) {
            const myChart = echarts.init(document.getElementById('main'));
            const stockId = stock_id;
            let curType = 'rt';
            let optionHis = {};
            let optionRt = {};
            //历史表 - 数据模型 time0 open1 close2 min3 max4 vol5 macd6 dif7 dea8
            let dataHis = [];
            //实时表 - 数据模型 time0 price1 涨跌幅3
            let dataRt = [];

            //数据模型 time0 open1 close2 min3 max4 vol5 tag6 macd7 dif8 dea9
            function handleHistoryData(rawData) {
                const categoryData = [];
                const values = [];
                const vols = [];
                const macds = [];
                const difs = [];
                const deas = [];
                for (let i = 0; i < rawData.length; i++) {
                    categoryData.push(rawData[i].splice(0, 1)[0]);
                    values.push(rawData[i]);
                    vols.push(rawData[i][4]);
                    macds.push(rawData[i][5]);
                    difs.push(rawData[i][6]);
                    deas.push(rawData[i][7]);
                }
                return {
                    categoryData: categoryData,
                    values: values,
                    vols: vols,
                    macds: macds,
                    difs: difs,
                    deas: deas
                };
            }

            function handleRtData(rawData, basePrice) {
                const categoryData = [];
                const values = [];
                const amplitude = [];
                const volume = [];
                const prices = [];
                for (let i = 0; i < rawData.length; i++) {
                    categoryData.push(rawData[i].splice(0, 1)[0]);
                    values.push(rawData[i]);
                    prices.push(rawData[i][0]);
                    amplitude.push(rawData[i][1]);
                    volume.push(rawData[i][2]);
                }
                const maxAmplitude = getAmplitude(prices, basePrice);
                const minPrice = Number(basePrice - basePrice * maxAmplitude).toFixed(2);
                const maxPrice = Number(basePrice + basePrice * maxAmplitude).toFixed(2);
                // TODO: n is magic number, 等差数列的项数
                const interval = Math.abs(Number((basePrice - minPrice) / 5));
                return {
                    categoryData: categoryData,
                    values: values,
                    prices: prices,
                    amplitudes: amplitude,
                    volumes: volume,
                    basePrice: basePrice,
                    maxPrice: maxPrice,
                    minPrice: minPrice,
                    interval: interval
                };
            }

            function calculateMA(dayCount) {
                const result = [];
                for (let i = 0; i < dataHis.values.length; i++) {
                    if (i < dayCount) {
                        result.push('-');
                        continue;
                    }
                    let sum = 0;
                    for (let j = 0; j < dayCount; j++) {
                        sum += dataHis.values[i - j][1];
                    }
                    result.push(sum / dayCount);
                }
                return result;
            }

            function flushOptionHis() {
                optionHis = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross'
                        }
                    },
                    grid: [{
                        left: '5%',
                        top: '5%',
                        height: '58%'
                    }, {
                        left: '5%',
                        right: '10%',
                        top: '69%',
                        height: '10%'
                    }, {
                        left: '5%',
                        right: '10%',
                        top: '82%',
                        height: '10%'
                    }],
                    xAxis: [{
                        type: 'category',
                        data: dataHis.categoryData,
                        scale: true,
                        boundaryGap: false,
                        axisLine: {
                            onZero: false,
                            lineStyle: {
                                color: 'red',
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        splitNumber: 20
                    }, {
                        type: 'category',
                        gridIndex: 1,
                        data: dataHis.categoryData,
                        axisLabel: {
                            show: false
                        },

                    }, {
                        type: 'category',
                        gridIndex: 2,
                        data: dataHis.categoryData,
                        axisLabel: {
                            show: false
                        },

                    }],
                    yAxis: [{
                        scale: true,
                        splitArea: {
                            show: true
                        },
                        axisLine: {
                            lineStyle: {
                                color: 'red',
                            }
                        },
                        position: 'left'
                    }, {
                        gridIndex: 1,
                        splitNumber: 3,
                        axisLine: {
                            onZero: false,
                            lineStyle: {
                                color: 'red'

                            }
                        },
                        axisTick: {
                            show: false
                        },
                        splitLine: {
                            show: false
                        },
                        axisLabel: {
                            show: true
                        },
                        position: 'left'
                    }, {
                        gridIndex: 2,
                        splitNumber: 4,
                        axisLine: {
                            onZero: false,
                            lineStyle: {
                                color: 'red'

                            }
                        },
                        axisTick: {
                            show: false
                        },
                        splitLine: {
                            show: false
                        },
                        axisLabel: {
                            show: true
                        },
                        position: 'left'
                    }],
                    dataZoom: [{
                        type: 'inside',
                        start: 100,
                        end: 80
                    }, {
                        y: '94%',
                        xAxisIndex: [0, 1],
                        start: 50,
                        end: 100
                    }, {
                        show: false,
                        xAxisIndex: [0, 2],
                        type: 'slider',
                        start: 20,
                        end: 100
                    }],
                    series: [{
                        name: '555',
                        type: 'candlestick',
                        data: dataHis.values,
                        markPoint: {
                            data: [{
                                name: 'XX标点'
                            }]
                        },
                        markLine: {
                            silent: true,
                            data: [{
                                yAxis: 2222,
                            }]
                        }
                    }, {
                        name: 'MA5',
                        type: 'line',
                        data: calculateMA(5),
                        smooth: true,
                        lineStyle: {
                            normal: {
                                opacity: 0.5
                            }
                        }
                    }, {
                        name: 'MA10',
                        type: 'line',
                        data: calculateMA(10),
                        smooth: true,
                        lineStyle: {
                            normal: {
                                opacity: 0.5
                            }
                        }
                    }, {
                        name: 'MA20',
                        type: 'line',
                        data: calculateMA(20),
                        smooth: true,
                        lineStyle: {
                            normal: {
                                opacity: 0.5
                            }
                        }
                    }, {
                        name: 'MA30',
                        type: 'line',
                        data: calculateMA(30),
                        smooth: true,
                        lineStyle: {
                            normal: {
                                opacity: 0.5
                            }
                        }
                    }, {
                        name: 'Volumn',
                        type: 'bar',
                        xAxisIndex: 1,
                        yAxisIndex: 1,
                        data: dataHis.vols,
                        itemStyle: {
                            normal: {
                                color: function (params) {
                                    let colorList;
                                    if (dataHis.values[params.dataIndex][1] > dataHis.values[params.dataIndex][0]) {
                                        colorList = '#ef232a';
                                    } else {
                                        colorList = '#14b143';
                                    }
                                    return colorList;
                                },
                            }
                        }
                    }, {
                        name: 'MACD',
                        type: 'bar',
                        xAxisIndex: 2,
                        yAxisIndex: 2,
                        data: dataHis.macds,
                        itemStyle: {
                            normal: {
                                color: function (params) {
                                    let colorList;
                                    if (params.data >= 0) {
                                        colorList = '#ef232a';
                                    } else {
                                        colorList = '#14b143';
                                    }
                                    return colorList;
                                },
                            }
                        }
                    }, {
                        name: 'DIF',
                        type: 'line',
                        xAxisIndex: 2,
                        yAxisIndex: 2,
                        data: dataHis.difs
                    }, {
                        name: 'DEA',
                        type: 'line',
                        xAxisIndex: 2,
                        yAxisIndex: 2,
                        data: dataHis.deas
                    }],
                    toolbox: {
                        show: true,
                        orient: 'horizontal',      // 布局方式，默认为水平布局，可选为：
                        x: 'left',                // 水平安放位置，默认为全图右对齐，可选为：
                        y: 'top',                  // 垂直安放位置，默认为全图顶端，可选为：
                        color: ['#1e90ff', '#22bb22', '#4b0082', '#d2691e'],
                        backgroundColor: 'rgba(0,0,0,0)', // 工具箱背景颜色
                        borderColor: '#ccc',       // 工具箱边框颜色
                        borderWidth: 0,            // 工具箱边框线宽，单位px，默认为0（无边框）
                        padding: 5,                // 工具箱内边距，单位px，默认各方向内边距为5，
                        showTitle: true,
                        feature: {
                            mark: {
                                show: true,
                                title: {
                                    mark: '辅助线-开关',
                                    markUndo: '辅助线-删除',
                                    markClear: '辅助线-清空'
                                },
                                lineStyle: {
                                    width: 1,
                                    color: '#1e90ff',
                                    type: 'dashed'
                                }
                            },
                            dataZoom: {
                                show: true,
                                title: {
                                    dataZoom: '区域缩放',
                                    dataZoomReset: '区域缩放-后退'
                                }
                            },
                            restore: {
                                show: true,
                                title: '还原',
                                color: 'black'
                            },
                            saveAsImage: {
                                show: true,
                                title: '保存为图片',
                                type: 'jpeg',
                                lang: ['点击本地保存']
                            },
                            myChangeRt: {
                                show: curType == 'rt' ? false : true,
                                title: '实时股价',
                                icon: 'image://asset/ico/rt.svg',
                                onclick: function () {
                                    flushRt();
                                }
                            },
                            myChangeDayK: {
                                show: curType == 'day' ? false : true,
                                title: '日K线',
                                icon: 'image://asset/ico/day.svg',
                                onclick: function () {
                                    flushHis('day');
                                }
                            },
                            myChangeWeekK: {
                                show: curType == 'week' ? false : true,
                                title: '周K线',
                                icon: 'image://asset/ico/week.svg',
                                onclick: function () {
                                    flushHis('week');
                                }
                            },
                            myChangeMonthK: {
                                show: curType == 'month' ? false : true,
                                title: '月K线',
                                icon: 'image://asset/ico/month.svg',
                                onclick: function () {
                                    flushHis('month');
                                }
                            },
                            myChangeYearK: {
                                show: curType == 'year' ? false : true,
                                title: '年K线',
                                icon: 'image://asset/ico/year.svg',
                                onclick: function () {
                                    flushHis('year');
                                }
                            }
                        }
                    }
                };
            }

            function ratioCalculate(price, yclose) {
                return ((price - yclose) / yclose * 100).toFixed(2);
            }

            function getAmplitude(prices, baseNumber) {
                const amplitude1 = Math.abs((Math.max.apply(null, prices) - baseNumber) / baseNumber).toFixed(2);
                const amplitude2 = Math.abs((baseNumber - Math.min.apply(null, prices)) / baseNumber).toFixed(2);
                return amplitude1 > amplitude2 ? amplitude1 : amplitude2;
            }

            function flushOptionRt() {
                optionRt = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross'
                        },
                        formatter: function (params, ticket, callback) {
                            const i = params[0].dataIndex;
                            let color;
                            if (dataRt.prices[i] > dataRt.basePrice) {
                                color = 'style="color:' + "#ff0000" + '"';
                            } else {
                                color = 'style="color:' + "#008b00" + '"';
                            }
                            return '<div class="commColor" style="width:130px;">\
                        <div>Price <span  ' + color + ' >' + dataRt.prices[i] + '</span></div>\
			            <div>Amplitude <span  ' + color + ' >' + dataRt.amplitudes[i] + '%</span></div>\
				        <div>Volume <span  ' + color + ' >' + dataRt.volumes[i] + '</span></div></div>';
                        }
                    },
                    grid: [{
                        left: '5%',
                        top: '5%',
                        height: '58%'
                    }, {
                        left: '5%',
                        top: '5%',
                        height: '58%'
                    }, {
                        left: '5%',
                        right: '8%',
                        top: '69%',
                        height: '10%'
                    }],
                    xAxis: [{ //主图
                        type: 'category',
                        data: dataRt.categoryData,
                        gridIndex: 0,
                        scale: true,
                        boundaryGap: false,
                        axisTick: {
                            show: false
                        },
                        axisLine: {
                            onZero: false,
                            lineStyle: {
                                color: 'red',
                            }
                        },
                        axisLabel: { //label文字设置
                            show: false
                        },
                        splitLine: { //分割线设置
                            show: false
                        },
                        splitNumber: 20
                    }, {
                        show: false,
                        gridIndex: 1,
                        boundaryGap: false,
                        axisLine: {
                            lineStyle: {
                                color: 'red',
                            }
                        },
                        axisLabel: { //label文字设置
                            show: false
                        },
                    }, {
                        type: 'category',
                        gridIndex: 2,
                        data: dataRt.categoryData,
                        axisLabel: {
                            show: false
                        }
                    }],
                    yAxis: [{
                        type: 'value',
                        min: dataRt.minPrice,
                        max: dataRt.maxPrice,
                        interval: dataRt.interval,
                        scale: true,
                        axisTick: { // 分割线 短
                            show: false
                        },
                        axisLine: {
                            lineStyle: {
                                color: "#bebebe",
                            }
                        },
                        axisPointer: {
                            show: true,
                            label: {
                                formatter: function (params) {
                                    return (params.value).toFixed(2);
                                }
                            }
                        },
                        axisLabel: {
                            color: '#333',
                            formatter: function getColor(value) {
                                value = value.toFixed(2)
                                if (value > dataRt.basePrice) {
                                    return '{red|' + value + '}';
                                } else if (value == dataRt.basePrice) {
                                    return value;
                                } else {
                                    return '{green|' + value + '}';
                                }
                            },
                            rich: {
                                red: {
                                    color: 'red',
                                    lineHeight: 10
                                },
                                green: {
                                    color: 'green',
                                    lineHeight: 10
                                }
                            }
                        },
                        z: 4,
                        splitLine: { //分割线设置
                            show: true,
                            lineStyle: {
                                type: 'dashed'
                            }
                        },
                    }, {
                        scale: true,
                        gridIndex: 1,
                        min: dataRt.minPrice,
                        max: dataRt.maxPrice,
                        interval: dataRt.interval,
                        position: 'right',
                        z: 4,
                        axisTick: {
                            show: false
                        },
                        axisLine: {
                            lineStyle: {
                                color: "#bebebe",
                            }
                        },
                        axisLabel: { //label文字设置
                            color: function (value) {
                                value = Number(value).toFixed(2)
                                if (value == dataRt.basePrice) {
                                    return '#333'
                                }
                                return value > dataRt.basePrice ? "#ff0000" : "#008b00";
                            },
                            formatter: function (value) {
                                const result = ratioCalculate(value, dataRt.basePrice);
                                return Number(result).toFixed(2) + '%'
                            }
                        },
                        splitLine: { //分割线设置
                            show: false,
                            lineStyle: {
                                color: '#181a23'
                            }
                        },
                        axisPointer: {
                            show: true,
                            label: {
                                formatter: function (params) { //计算右边Y轴对应的当前价的涨幅比例
                                    return ratioCalculate(params.value, dataRt.basePrice) + '%';
                                }
                            }
                        }
                    }, {
                        gridIndex: 2,
                        splitNumber: 3,
                        axisLine: {
                            onZero: false,
                            lineStyle: {
                                color: 'red'

                            }
                        },
                        axisTick: {
                            show: false
                        },
                        splitLine: {
                            show: false
                        },
                        axisLabel: {
                            show: true
                        },
                        position: 'left'
                    }],
                    dataZoom: [{
                        type: 'inside',
                        start: 0,
                        end: 100
                    }, {
                        show: true,
                        y: '84%',
                        xAxisIndex: [0, 1],
                        start: 0,
                        end: 100
                    }],
                    series: [{
                        name: 'price',
                        type: 'line',
                        data: dataRt.prices,
                        smooth: true,
                        symbol: "circle", //中时有小圆点
                        lineStyle: {
                            normal: {
                                opacity: 0.8,
                                color: '#39afe6',
                                width: 1
                            }
                        },
                        areaStyle: {
                            normal: {
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: 'rgba(0, 136, 212, 0.7)'
                                }, {
                                    offset: 0.8,
                                    color: 'rgba(0, 136, 212, 0.02)'
                                }], false),
                                shadowColor: 'rgba(0, 0, 0, 0.1)',
                                shadowBlur: 10
                            }
                        },
                        markLine: {
                            name: 'Base price',
                            symbol: ['none', 'none'],
                            label: {
                                show: false,
                                formatter: Number(dataRt.basePrice).toFixed(2),
                                position: 'start',
                            },
                            lineStyle: {
                                color: '#4289c5',
                                type: 'solid'
                            },
                            data: [{
                                yAxis: dataRt.basePrice
                            }]
                        }
                    }, {
                        name: 'Volume',
                        type: 'bar',
                        gridIndex: 2,
                        xAxisIndex: 2,
                        yAxisIndex: 2,
                        data: dataRt.volumes,
                        barWidth: '60%',
                        itemStyle: {
                            normal: {
                                color: function (params) {
                                    return dataRt.prices[params.dataIndex] > dataRt.prices[params.dataIndex - 1] ? "#ff0000" : "#008b00";
                                }
                            }
                        }
                    }],
                    toolbox: {
                        show: true,
                        orient: 'horizontal',      // 布局方式，默认为水平布局，可选为：
                        x: 'left',                // 水平安放位置，默认为全图右对齐，可选为：
                        y: 'top',                  // 垂直安放位置，默认为全图顶端，可选为：
                        color: ['#1e90ff', '#22bb22', '#4b0082', '#d2691e'],
                        backgroundColor: 'rgba(0,0,0,0)', // 工具箱背景颜色
                        borderColor: '#ccc',       // 工具箱边框颜色
                        borderWidth: 0,            // 工具箱边框线宽，单位px，默认为0（无边框）
                        padding: 5,                // 工具箱内边距，单位px，默认各方向内边距为5，
                        showTitle: true,
                        feature: {
                            mark: {
                                show: true,
                                title: {
                                    mark: '辅助线-开关',
                                    markUndo: '辅助线-删除',
                                    markClear: '辅助线-清空'
                                },
                                lineStyle: {
                                    width: 1,
                                    color: '#1e90ff',
                                    type: 'dashed'
                                }
                            },
                            dataZoom: {
                                show: true,
                                title: {
                                    dataZoom: '区域缩放',
                                    dataZoomReset: '区域缩放-后退'
                                }
                            },
                            restore: {
                                show: true,
                                title: '还原',
                                color: 'black'
                            },
                            saveAsImage: {
                                show: true,
                                title: '保存为图片',
                                type: 'jpeg',
                                lang: ['点击本地保存']
                            },
                            myChangeDayK: {
                                show: curType == 'day' ? false : true,
                                title: '日K线',
                                itemSize: 200,
                                icon: 'image://asset/ico/day.svg',
                                onclick: function () {
                                    flushHis('day');
                                }
                            },
                            myChangeWeekK: {
                                show: curType == 'week' ? false : true,
                                title: '周K线',
                                icon: 'image://asset/ico/week.svg',
                                onclick: function () {
                                    flushHis('week');
                                }
                            },
                            myChangeMonthK: {
                                show: curType == 'month' ? false : true,
                                title: '月K线',
                                icon: 'image://asset/ico/month.svg',
                                onclick: function () {
                                    flushHis('month');
                                }
                            },
                            myChangeYearK: {
                                show: curType == 'year' ? false : true,
                                title: '年K线',
                                icon: 'image://asset/ico/year.svg',
                                onclick: function () {
                                    flushHis('year');
                                }
                            }
                        }
                    }
                };
            }

            function flushRt() {
                var vm = new Vue({
                    methods: {
                        get: function () {
                            this.$http.get('http://127.0.0.1:8088/get_rt$', {
                                stock_id: stockId
                            }).then(function (res) {
                                dataRt = handleRtData(res.body.data, res.body.basePrice);
                                flushOptionRt();
                                myChart.setOption(optionRt, true);
                                curType = 'rt';
                            }, function () {
                                console.log('请求失败处理');
                            });
                        }
                    }
                });
                vm.get();
            }

            function flushHis(interval) {
                var vm = new Vue({
                    methods: {
                        get: function () {
                            this.$http.get('http://127.0.0.1:8088/get_his', {
                                stock_id: stockId,
                                interval: interval
                            }).then(function (res) {
                                dataHis = handleHistoryData(res.body.data);
                                flushOptionHis();
                                myChart.setOption(optionHis, true);
                                curType = interval;
                            }, function () {
                                console.log('请求失败处理');
                            });
                        }
                    }
                });
                vm.get();
            }

            this.show = function () {
                flushRt();
            };

            this.flushData = function () {
                if (curType == 'rt') {
                }
                console.log(Date.now());
            }
        }

    )
;