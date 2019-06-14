const Kline = (function (stock_id) {
            const dom = document.getElementById("main");
            const myChart = echarts.init(dom);

            const stockId = stock_id;
            const downColor = '#26A69A';
            const upColor = '#EF5350';
            const lightDownColor = '#C3E7D5';
            const lightUpColor = '#F8C1C6';

            let curType = 'rt';

            let optionHis = {};
            let optionRt = {};

            let dataHis = [];
            let dataRt = [];

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
                        left: '7%',
                        top: '5%',
                        height: '58%'
                    }, {
                        left: '7%',
                        right: '10%',
                        top: '69%',
                        height: '10%'
                    }, {
                        left: '7%',
                        right: '12%',
                        top: '82%',
                        height: '10%'
                    }],
                    legend: {
                        data: ['K线', 'MA5', 'MA10', 'MA20', 'MA30']
                    },
                    xAxis: [{
                        type: 'category',
                        data: dataHis.categoryData,
                        scale: true,
                        boundaryGap: false,
                        axisLine: {
                            onZero: false,
                            lineStyle: {
                                color: "#bebebe",
                            }
                        },
                        splitLine: {
                            show: false
                        },
                        splitNumber: 5
                    }, {
                        type: 'category',
                        gridIndex: 1,
                        data: dataHis.categoryData,
                        axisLine: {
                            lineStyle: {
                                color: "#bebebe",
                            }
                        },
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
                        axisLine: {
                            lineStyle: {
                                color: "#bebebe",
                            }
                        }
                    }],
                    yAxis: [{
                        scale: true,
                        splitArea: {
                            show: true
                        },
                        axisLine: {
                            lineStyle: {
                                color: "#bebebe",
                            }
                        },
                        position: 'left'
                    }, {
                        gridIndex: 1,
                        splitNumber: 3,
                        axisLine: {
                            onZero: false,
                            lineStyle: {
                                color: "#bebebe",
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
                                color: "#bebebe",
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
                        start: 50,
                        end: 100
                    }, {
                        y: '94%',
                        xAxisIndex: [0, 1],
                        start: 50,
                        end: 100
                    }, {
                        show: false,
                        xAxisIndex: [0, 2],
                        type: 'slider',
                        start: 50,
                        end: 100
                    }],
                    series: [{
                        name: 'K线',
                        type: 'candlestick',
                        data: dataHis.values,
                        itemStyle: {
                            normal: {
                                color: upColor,
                                color0: downColor,
                                borderColor: upColor,
                                borderColor0: downColor
                            }
                        },
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
                        name: '交易量',
                        type: 'bar',
                        xAxisIndex: 1,
                        yAxisIndex: 1,
                        data: dataHis.vols,
                        itemStyle: {
                            normal: {
                                color: function (params) {
                                    let colorList;
                                    if (dataHis.values[params.dataIndex][1] > dataHis.values[params.dataIndex][0]) {
                                        colorList = lightUpColor;
                                    } else {
                                        colorList = lightDownColor;
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
                                        colorList = upColor;
                                    } else {
                                        colorList = downColor;
                                    }
                                    return colorList;
                                }
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
                        orient: 'vertical',      // 布局方式，默认为水平布局，可选为：
                        x: 'left',                // 水平安放位置，默认为全图右对齐，可选为：
                        y: 'top',                  // 垂直安放位置，默认为全图顶端，可选为：
                        color: ['#1e90ff', '#22bb22', '#4b0082', '#d2691e'],
                        backgroundColor: 'rgba(0,0,0,0)', // 工具箱背景颜色
                        borderColor: '#ccc',       // 工具箱边框颜色
                        borderWidth: 0,            // 工具箱边框线宽，单位px，默认为0（无边框）
                        padding: 5,                // 工具箱内边距，单位px，默认各方向内边距为5，
                        showTitle: true,
                        itemSize: 20,
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
                                show: curType !== 'rt',
                                title: '实时股价',
                                icon: 'path://M516.73088 59.43296c-172.4416 0-334.37696 99.65568-408.08448 246.45632l-12.30848-79.38048c-6.77888-19.41504-17.89952-30.0032-40.6528-25.88672-22.7328 4.11648-27.09504 19.39456-27.09504 38.8096l26.7264 165.84704c-0.512 5.67296 0.43008 11.61216 3.46112 17.34656 13.25056 25.04704 47.43168 12.94336 47.43168 12.94336l176.14848-84.0704c13.55776-12.94336 24.12544-25.1904 13.55776-45.2608-10.56768-20.09088-33.87392-19.39456-47.43168-12.94336l-85.83168 42.5984c61.80864-129.92512 202.38336-218.23488 354.07872-218.23488 216.80128 0 386.17088 161.6896 386.17088 368.64s-176.14848 368.64-386.17088 368.64c-101.62176 0-196.48512-38.8096-271.01184-109.93664a33.83296 33.83296 0 0 0-47.43168 0c-13.55776 12.94336-13.55776 32.33792 0 45.28128 81.3056 84.0704 196.48512 129.35168 318.42304 129.35168 250.6752 0 453.91872-194.02752 453.91872-426.84416 0.04096-239.34976-203.22304-433.3568-453.89824-433.3568z M500.3264 305.19296c-19.27168 0-32.13312 12.20608-32.13312 30.5152v164.78208c0 5.77536 1.41312 10.8544 3.74784 15.21664 2.39616 5.7344 6.8608 10.91584 13.45536 14.90944l146.24768 88.59648c16.26112 9.85088 33.9968 6.12352 44.35968-9.33888 10.36288-15.44192 6.43072-32.29696-9.80992-42.14784l-133.75488-81.01888v-151.01952c0.02048-18.28864-12.82048-30.49472-32.11264-30.49472z',
                                onclick: function () {
                                    flushRt();
                                }
                            },
                            myChangeDayK: {
                                show: curType !== 'day',
                                title: '日K线',
                                icon: 'path://M675.071 674.757c0 16.206-5.064 28.867-15.193 37.983-10.128 9.115-22.79 13.674-38.489 13.674H401.092c-15.699 0-28.36-4.559-37.983-13.674-10.128-9.116-15.193-21.777-15.193-37.983V393.181c0-16.206 5.064-28.36 15.193-37.476s22.79-13.167 37.983-13.167H621.39c18.231 0 31.4 4.558 40.515 13.167 8.61 9.116 13.167 21.27 13.167 37.476v281.576zM621.39 412.932c0-6.584-1.012-10.635-2.532-12.662-1.52-2.026-5.064-3.038-10.128-3.038h-195.99c-6.076 0-9.622 1.012-10.127 3.544-1.013 2.532-1.52 5.064-1.52 8.61v91.159H621.39v-87.613zm0 142.307H401.092v99.767c0 7.09.507 11.142 1.52 13.167 1.012 2.027 4.558 3.04 10.635 3.04h195.989c7.09 0 10.635-2.027 11.647-5.572.507-4.051 1.013-8.103 1.013-13.167V555.24h-.507zM420.336 199.218h168.136c14.18 0 25.321-14.18 25.321-27.854 0-16.711-11.142-27.853-25.321-27.853H420.336c-14.18 0-25.322 14.18-25.322 27.853 0 16.712 11.142 27.854 25.322 27.854zm252.203 30.892c16.712 0 27.854-11.141 27.854-22.283v-90.144c0-14.18-11.142-22.284-27.854-22.284-16.713 0-27.854 11.142-27.854 22.284v89.638c0 14.18 14.18 22.79 27.854 22.79z M773.825 140.472h-17.219c-16.712 0-27.853 14.18-27.853 27.854 0 16.711 14.18 27.853 27.853 27.853h16.713c53.175 0 100.78 42.034 100.78 98.248v473.514c0 53.175-45.072 98.248-100.78 98.248H246.63c-53.175 0-100.78-45.073-100.78-98.248V296.959c0-53.175 45.072-98.248 98.248-98.248 16.713 0 27.854-14.18 27.854-27.853 0-16.712-11.142-27.854-27.854-27.854-84.067-3.039-153.955 67.355-153.955 153.955v474.02a156.484 156.484 0 0 0 156.994 156.994h529.727a156.484 156.484 0 0 0 156.994-156.994V297.465c-3.04-87.106-73.433-156.993-160.033-156.993z M336.269 230.11c16.712 0 27.853-11.141 27.853-22.283v-90.144c0-14.18-14.18-22.284-27.853-22.284-16.713 0-27.854 11.142-27.854 22.284v89.638c0 14.18 13.674 22.79 27.854 22.79z',
                                onclick: function () {
                                    flushHis('day');
                                }
                            },
                            myChangeWeekK: {
                                show: curType !== 'week',
                                title: '周K线',
                                icon: 'path://M425.54368 195.8144h170.07104c14.16704 0 25.49248-14.17216 25.49248-28.34432 0-17.02912-11.32544-28.34944-25.49248-28.34944H425.54368c-14.17216 0-25.49248 14.17216-25.49248 28.34944 0.00512 17.02912 11.32032 28.34432 25.49248 28.34432z m255.104 31.19616c17.02912 0 28.34944-11.31008 28.34944-22.6304V113.63328c0-14.17216-11.32032-22.6304-28.34944-22.6304s-28.3392 11.3152-28.3392 22.6304v90.63936c0 14.17728 14.16192 22.73792 28.3392 22.73792z M782.60736 136.2688h-17.02912c-17.024 0-28.34432 14.17216-28.34432 28.34944 0 17.02912 14.17216 28.34432 28.34432 28.34432h17.02912c53.8368 0 102.0672 42.51648 102.0672 99.20512v478.8992c0 53.83168-45.36832 99.21024-102.0672 99.21024H249.76384c-53.83168 0-102.06208-45.37856-102.06208-99.21024V295.01952c0-53.83168 45.36832-99.20512 99.20512-99.20512 17.02912 0 28.34944-14.17216 28.34944-28.34432 0-17.02912-11.32032-28.34944-28.34944-28.34944-84.92544-2.85696-155.78624 68.00384-155.78624 155.89376v478.8992c0 87.8848 70.86592 158.75072 158.75072 158.75072h535.5776c87.89504 0 158.75584-70.86592 158.75584-158.75072V295.01952c-2.85184-87.88992-73.70752-158.75072-161.59744-158.75072z M340.51072 227.01056c17.02912 0 28.34432-11.31008 28.34432-22.6304V113.63328c0-14.17216-14.17216-22.6304-28.34432-22.6304-17.02912 0-28.34944 11.3152-28.34944 22.6304v90.63936c0.00512 14.17728 14.17728 22.73792 28.34944 22.73792zM399.95904 555.32032c-0.3328 25.00096-0.9984 47.0016-2.00192 66.00192-1.33632 26.33728-3.99872 48-8.00256 64.9984-6.00064 20.66432-15.17056 40.4992-27.49952 59.49952a97.83808 97.83808 0 0 1-10.99776 14.49984 390.41024 390.41024 0 0 1-16.50176 16.50176 532.93568 532.93568 0 0 0-22.00064-23.5008c-9.00096-8.66816-18.00192-16.16896-26.99776-22.5024 14.66368-11.33568 25.4976-22.99904 32.50176-35.00032 13.32736-20.66432 21.00224-53.16608 22.99904-97.50016 0.9984-8.33024 1.50016-22.00064 1.50016-41.00096l0.50176-68.50048c0-29.32736-0.50176-56.4992-1.50016-81.50016s-2.49856-53.00224-4.50048-83.99872l62.49984 1.50016h262.5024l63.49824-1.50016-2.00192 60.99968v346.50112c-0.3328 10.33216-1.17248 17.50016-2.49856 21.49888-2.66752 5.66272-7.5008 10.1632-14.49984 13.50144a131.84 131.84 0 0 1-26.99776 9.99936l-41.4976 5.49888c-3.67104-16.9984-10.99776-37.66784-22.00064-61.99808l22.00064 0.50176c9.00096-0.3328 15.49824-1.17248 19.50208-2.49856 2.66752-2.00192 4.50048-5.1712 5.49888-9.4976l0.9984-326.99904H400.4608l-0.50176 174.49472z m12.50304-54.5024l88.00256 0.9984v-28.00128l-79.49824 0.9984V422.81984l80 0.9984c-0.9984-6.00064-1.50016-18.00192-1.50016-35.99872h60.49792a363.2128 363.2128 0 0 0-0.9984 26.99776c0 3.00032 0.16384 6.00064 0.50176 9.00096l85.49888-0.9984v51.99872c-12.33408-0.6656-24.17152-0.9984-35.50208-0.9984h-50.49856v28.00128l96-0.9984v50.49856a832.8192 832.8192 0 0 0-40.4992-0.9984H453.45792c-13.99808 0.3328-27.66848 0.67072-41.00096 0.9984v-50.50368z m15.49824 162.00192l-1.50016-95.0016 51.99872 2.00192h108.00128l52.50048-2.00192-1.50016 51.50208 1.50016 95.49824-52.50048-2.00192H477.46048l-51.00032 2.00192 1.50016-51.99872z m152.4992 0.9984v-44.49792H482.4576v44.49792h98.00192z',
                                onclick: function () {
                                    flushHis('week');
                                }
                            },
                            myChangeMonthK: {
                                show: curType !== 'month',
                                title: '月K线',
                                icon: 'path://M425.544098 195.814269h170.070384c14.165619 0 25.489817-14.170804 25.489817-28.341607 0-17.027779-11.324199-28.346792-25.489817-28.346792h-170.070384c-14.170804 0-25.489817 14.170804-25.489817 28.346792 0 17.027779 11.319014 28.341607 25.489817 28.341607z m255.105575 31.198582c17.027779 0 28.346792-11.313829 28.346793-22.632842V113.636052c0-14.170804-11.319014-22.632842-28.346793-22.632842s-28.341607 11.313829-28.341607 22.632842v90.635071c0 14.175989 14.165619 22.741729 28.341607 22.741728z M782.603757 136.268895h-17.027778c-17.027779 0-28.346792 14.170804-28.346793 28.346792 0 17.027779 14.170804 28.341607 28.346793 28.341607h17.027778c53.836609 0 102.06297 42.517596 102.06297 99.205995v478.893311c0 53.831424-45.369386 99.21118-102.06297 99.211181H249.76495c-53.831424 0-102.06297-45.379756-102.06297-99.211181V295.020264c0-53.831424 45.369386-99.205995 99.205995-99.205995 17.027779 0 28.346792-14.170804 28.346792-28.341607 0-17.027779-11.319014-28.346792-28.346792-28.346792-84.926305-2.856975-155.785508 68.002228-155.785508 155.894394v478.898496c0 87.886982 70.864388 158.75137 158.75137 158.75137h535.58171c87.892167 0 158.75137-70.864388 158.75137-158.75137V295.020264c-2.85179-87.892167-73.710993-158.75137-161.60316-158.751369z M340.508907 227.012851c17.027779 0 28.346792-11.313829 28.346792-22.632842V113.636052c0-14.170804-14.170804-22.632842-28.346792-22.632842-17.027779 0-28.346792 11.313829-28.346792 22.632842v90.635071c0.005185 14.175989 14.175989 22.741729 28.346792 22.741728z m8.570925 507.234919l14.170803 11.324198c2.856975 2.856975 5.71395 2.856975 8.462039 2.856975 2.856975 0 8.456854-2.856975 8.456854-5.71395 31.203767-36.808831 50.979634-85.035192 56.688399-144.585751h195.555015v96.34902c0 8.462039-2.856975 8.462039-5.71395 8.462039h-62.293463c-5.71395 0-8.462039 2.856975-11.319013 5.719135-2.856975 2.856975-2.856975 8.456854-2.856975 11.313828l5.71395 14.170804c2.856975 5.71395 8.462039 8.462039 14.170803 8.462039h62.293463c28.346792 0 42.517596-17.032964 42.517596-45.374571v-354.088612c0-8.462039-5.719135-14.170804-14.170803-14.170804H408.625206c-8.456854 0-14.170804 5.71395-14.170803 14.170804v221.044832c0 62.293463-17.027779 110.519824-48.231546 150.18563-2.856975 5.708765-2.856975 14.165619 2.856975 19.874384z m93.492045-362.763239h192.69804v70.864388H442.571877V371.484531z m0 113.381984h192.69804v70.859203H442.571877V484.866515z',
                                onclick: function () {
                                    flushHis('month');
                                }
                            },
                            myChangeYearK: {
                                show: curType !== 'year',
                                title: '年K线',
                                icon: 'path://M425.544098 195.814269h170.070384c14.165619 0 25.489817-14.170804 25.489817-28.341607 0-17.027779-11.324199-28.346792-25.489817-28.346792h-170.070384c-14.170804 0-25.489817 14.170804-25.489817 28.346792 0 17.027779 11.319014 28.341607 25.489817 28.341607z m255.105575 31.198582c17.022594 0 28.346792-11.313829 28.346793-22.632842V113.636052c0-14.170804-11.324199-22.632842-28.346793-22.632842-17.032964 0-28.346792 11.313829-28.346792 22.632842v90.635071c0.005185 14.175989 14.170804 22.741729 28.346792 22.741728z M782.603757 136.268895h-17.022593c-17.027779 0-28.346792 14.170804-28.346793 28.346792 0 17.027779 14.165619 28.341607 28.346793 28.341607h17.022593c53.836609 0 102.068155 42.517596 102.068156 99.205995v478.893311c0 53.831424-45.369386 99.21118-102.068156 99.211181H249.76495c-53.831424 0-102.06297-45.379756-102.06297-99.211181V295.020264c0-53.831424 45.369386-99.205995 99.205995-99.205995 17.027779 0 28.346792-14.170804 28.346792-28.341607 0-17.027779-11.319014-28.346792-28.346792-28.346792-84.926305-2.856975-155.785508 68.002228-155.785508 155.894394v478.898496c0 87.886982 70.864388 158.75137 158.75137 158.75137h535.58171c87.892167 0 158.75137-70.864388 158.75137-158.75137V295.020264c-2.85179-87.892167-73.710993-158.75137-161.60316-158.751369z M340.508907 227.012851c17.027779 0 28.346792-11.313829 28.346792-22.632842V113.636052c0-14.170804-14.170804-22.632842-28.346792-22.632842-17.027779 0-28.346792 11.313829-28.346792 22.632842v90.635071c0.005185 14.175989 14.175989 22.741729 28.346792 22.741728zM320.421935 428.634402c18.780333-19.96253 39.344331-49.916695 61.67644-89.86768 12.910831-27.009043 26.4335-38.768788 40.526528-35.242939 17.618877 3.525849 24.670576 13.517484 21.144726 29.954165-1.187382 2.369578-2.945121 4.708046-5.288774 7.046514-2.369578 5.895428-3.525849 9.416092-3.52585 10.572363h248.458312c16.43668 1.187382 25.246119 9.99682 26.433501 26.433501 0 17.618877-8.233895 26.4335-24.670576 26.4335h-121.584769v54.624741h114.538255c14.098213 1.187382 22.300998 9.416092 24.670576 24.670575-1.187382 16.467791-8.809438 24.670576-22.907651 24.670576h-116.30118v86.34183h132.157132c14.098213 1.187382 21.144726 9.99682 21.144726 26.4335-1.187382 16.467791-8.809438 24.670576-22.907651 24.670576h-130.394207v59.913515c-1.187382 14.098213-9.99682 21.720269-26.4335 22.907651-17.618877 0-26.4335-7.046514-26.433501-21.144727v-61.676439H327.468449c-15.280409 0-23.514305-8.202785-24.670576-24.670576 1.156271-16.43668 9.390167-25.246119 24.670576-26.4335h40.526528V500.883204c-2.369578-29.347511 12.910831-43.445724 45.815302-42.289452H510.729657V403.963826H406.763765c-16.462606 28.196425-33.480014 49.341151-51.098891 63.434179-16.462606 11.759745-30.560818 12.335288-42.289452 1.762925-9.416092-11.723449-7.051699-25.246119 7.046513-40.526528z m98.677118 91.630604v74.006542H510.729657V507.929718H431.434341c-9.416092 1.182197-13.517484 5.283589-12.335288 12.335288z',
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
                        formatter: function (params) {
                            const i = params[0].dataIndex;
                            let color;
                            if (dataRt.prices[i] > dataRt.basePrice) {
                                color = 'style="color:' + downColor + '"';
                            } else {
                                color = 'style="color:' + upColor + '"';
                            }
                            return '<div class="commColor" style="width:130px;">\
                        <div>Price <span  ' + color + ' >' + dataRt.prices[i] + '</span></div>\
			            <div>Amplitude <span  ' + color + ' >' + dataRt.amplitudes[i] + '%</span></div>\
				        <div>Volume <span  ' + color + ' >' + dataRt.volumes[i] + '</span></div></div>';
                        }
                    },
                    grid: [{
                        left: '7%',
                        top: '5%',
                        height: '58%'
                    }, {
                        left: '7%',
                        top: '5%',
                        height: '58%'
                    }, {
                        left: '7%',
                        right: '10%',
                        top: '69%',
                        height: '10%'
                    }],
                    legend: {
                        data: ['实时价格', '交易量']
                    },
                    xAxis: [{ //主图
                        type: 'category',
                        data: dataRt.categoryData,
                        gridIndex: 0,
                        scale: true,
                        boundaryGap: false,
                        axisTick: {
                            show: true
                        },
                        axisLine: {
                            lineStyle: {
                                color: "#bebebe",
                            }
                        },
                        splitNumber: 5
                    }, {
                        show: false,
                        gridIndex: 1
                    }, {
                        type: 'category',
                        axisLabel: {
                            show: false
                        },
                        axisLine: {
                            lineStyle: {
                                color: "#bebebe",
                            }
                        },
                        gridIndex: 2,
                        data: dataRt.categoryData
                    }],
                    yAxis: [{
                        type: 'value',
                        min: dataRt.minPrice,
                        max: dataRt.maxPrice,
                        interval: dataRt.interval,
                        scale: true,
                        axisTick: {
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
                                    color: upColor,
                                    lineHeight: 10
                                },
                                green: {
                                    color: downColor,
                                    lineHeight: 10
                                }
                            }
                        },
                        z: 4,
                        splitLine: {
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
                                    return 'black'
                                }
                                return value > dataRt.basePrice ? upColor : downColor;
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
                                color: "#bebebe",
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
                        start: 50,
                        end: 100
                    }, {
                        y: '83%',
                        xAxisIndex: [0, 1],
                        start: 50,
                        end: 100
                    }, {
                        show: false,
                        xAxisIndex: [0, 2],
                        type: 'slider',
                        start: 50,
                        end: 100
                    }],
                    series: [{
                        name: '实时价格',
                        type: 'line',
                        data: dataRt.prices,
                        smooth: true,
                        symbol: "circle",
                        itemStyle: {
                            color: '#2196F3'
                        },
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
                        name: '交易量',
                        type: 'bar',
                        gridIndex: 2,
                        xAxisIndex: 2,
                        yAxisIndex: 2,
                        data: dataRt.volumes,
                        barWidth: '60%',
                        itemStyle: {
                            normal: {
                                color: function (params) {
                                    return dataRt.prices[params.dataIndex] > dataRt.prices[params.dataIndex - 1] ? upColor : downColor;
                                }
                            }
                        }
                    }],
                    toolbox: {
                        show: true,
                        orient: 'vertical',      // 布局方式，默认为水平布局，可选为：
                        x: 'left',                // 水平安放位置，默认为全图右对齐，可选为：
                        y: 'top',                  // 垂直安放位置，默认为全图顶端，可选为：
                        color: ['#1e90ff', '#22bb22', '#4b0082', '#d2691e'],
                        backgroundColor: 'rgba(0,0,0,0)', // 工具箱背景颜色
                        borderColor: '#ccc',       // 工具箱边框颜色
                        borderWidth: 0,            // 工具箱边框线宽，单位px，默认为0（无边框）
                        padding: 5,                // 工具箱内边距，单位px，默认各方向内边距为5，
                        showTitle: true,
                        itemSize: 20,
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
                                show: curType !== 'day',
                                title: '日K线',
                                icon: 'path://M675.071 674.757c0 16.206-5.064 28.867-15.193 37.983-10.128 9.115-22.79 13.674-38.489 13.674H401.092c-15.699 0-28.36-4.559-37.983-13.674-10.128-9.116-15.193-21.777-15.193-37.983V393.181c0-16.206 5.064-28.36 15.193-37.476s22.79-13.167 37.983-13.167H621.39c18.231 0 31.4 4.558 40.515 13.167 8.61 9.116 13.167 21.27 13.167 37.476v281.576zM621.39 412.932c0-6.584-1.012-10.635-2.532-12.662-1.52-2.026-5.064-3.038-10.128-3.038h-195.99c-6.076 0-9.622 1.012-10.127 3.544-1.013 2.532-1.52 5.064-1.52 8.61v91.159H621.39v-87.613zm0 142.307H401.092v99.767c0 7.09.507 11.142 1.52 13.167 1.012 2.027 4.558 3.04 10.635 3.04h195.989c7.09 0 10.635-2.027 11.647-5.572.507-4.051 1.013-8.103 1.013-13.167V555.24h-.507zM420.336 199.218h168.136c14.18 0 25.321-14.18 25.321-27.854 0-16.711-11.142-27.853-25.321-27.853H420.336c-14.18 0-25.322 14.18-25.322 27.853 0 16.712 11.142 27.854 25.322 27.854zm252.203 30.892c16.712 0 27.854-11.141 27.854-22.283v-90.144c0-14.18-11.142-22.284-27.854-22.284-16.713 0-27.854 11.142-27.854 22.284v89.638c0 14.18 14.18 22.79 27.854 22.79z M773.825 140.472h-17.219c-16.712 0-27.853 14.18-27.853 27.854 0 16.711 14.18 27.853 27.853 27.853h16.713c53.175 0 100.78 42.034 100.78 98.248v473.514c0 53.175-45.072 98.248-100.78 98.248H246.63c-53.175 0-100.78-45.073-100.78-98.248V296.959c0-53.175 45.072-98.248 98.248-98.248 16.713 0 27.854-14.18 27.854-27.853 0-16.712-11.142-27.854-27.854-27.854-84.067-3.039-153.955 67.355-153.955 153.955v474.02a156.484 156.484 0 0 0 156.994 156.994h529.727a156.484 156.484 0 0 0 156.994-156.994V297.465c-3.04-87.106-73.433-156.993-160.033-156.993z M336.269 230.11c16.712 0 27.853-11.141 27.853-22.283v-90.144c0-14.18-14.18-22.284-27.853-22.284-16.713 0-27.854 11.142-27.854 22.284v89.638c0 14.18 13.674 22.79 27.854 22.79z',
                                onclick: function () {
                                    flushHis('day');
                                }
                            },
                            myChangeWeekK: {
                                show: curType !== 'week',
                                title: '周K线',
                                icon: 'path://M425.54368 195.8144h170.07104c14.16704 0 25.49248-14.17216 25.49248-28.34432 0-17.02912-11.32544-28.34944-25.49248-28.34944H425.54368c-14.17216 0-25.49248 14.17216-25.49248 28.34944 0.00512 17.02912 11.32032 28.34432 25.49248 28.34432z m255.104 31.19616c17.02912 0 28.34944-11.31008 28.34944-22.6304V113.63328c0-14.17216-11.32032-22.6304-28.34944-22.6304s-28.3392 11.3152-28.3392 22.6304v90.63936c0 14.17728 14.16192 22.73792 28.3392 22.73792z M782.60736 136.2688h-17.02912c-17.024 0-28.34432 14.17216-28.34432 28.34944 0 17.02912 14.17216 28.34432 28.34432 28.34432h17.02912c53.8368 0 102.0672 42.51648 102.0672 99.20512v478.8992c0 53.83168-45.36832 99.21024-102.0672 99.21024H249.76384c-53.83168 0-102.06208-45.37856-102.06208-99.21024V295.01952c0-53.83168 45.36832-99.20512 99.20512-99.20512 17.02912 0 28.34944-14.17216 28.34944-28.34432 0-17.02912-11.32032-28.34944-28.34944-28.34944-84.92544-2.85696-155.78624 68.00384-155.78624 155.89376v478.8992c0 87.8848 70.86592 158.75072 158.75072 158.75072h535.5776c87.89504 0 158.75584-70.86592 158.75584-158.75072V295.01952c-2.85184-87.88992-73.70752-158.75072-161.59744-158.75072z M340.51072 227.01056c17.02912 0 28.34432-11.31008 28.34432-22.6304V113.63328c0-14.17216-14.17216-22.6304-28.34432-22.6304-17.02912 0-28.34944 11.3152-28.34944 22.6304v90.63936c0.00512 14.17728 14.17728 22.73792 28.34944 22.73792zM399.95904 555.32032c-0.3328 25.00096-0.9984 47.0016-2.00192 66.00192-1.33632 26.33728-3.99872 48-8.00256 64.9984-6.00064 20.66432-15.17056 40.4992-27.49952 59.49952a97.83808 97.83808 0 0 1-10.99776 14.49984 390.41024 390.41024 0 0 1-16.50176 16.50176 532.93568 532.93568 0 0 0-22.00064-23.5008c-9.00096-8.66816-18.00192-16.16896-26.99776-22.5024 14.66368-11.33568 25.4976-22.99904 32.50176-35.00032 13.32736-20.66432 21.00224-53.16608 22.99904-97.50016 0.9984-8.33024 1.50016-22.00064 1.50016-41.00096l0.50176-68.50048c0-29.32736-0.50176-56.4992-1.50016-81.50016s-2.49856-53.00224-4.50048-83.99872l62.49984 1.50016h262.5024l63.49824-1.50016-2.00192 60.99968v346.50112c-0.3328 10.33216-1.17248 17.50016-2.49856 21.49888-2.66752 5.66272-7.5008 10.1632-14.49984 13.50144a131.84 131.84 0 0 1-26.99776 9.99936l-41.4976 5.49888c-3.67104-16.9984-10.99776-37.66784-22.00064-61.99808l22.00064 0.50176c9.00096-0.3328 15.49824-1.17248 19.50208-2.49856 2.66752-2.00192 4.50048-5.1712 5.49888-9.4976l0.9984-326.99904H400.4608l-0.50176 174.49472z m12.50304-54.5024l88.00256 0.9984v-28.00128l-79.49824 0.9984V422.81984l80 0.9984c-0.9984-6.00064-1.50016-18.00192-1.50016-35.99872h60.49792a363.2128 363.2128 0 0 0-0.9984 26.99776c0 3.00032 0.16384 6.00064 0.50176 9.00096l85.49888-0.9984v51.99872c-12.33408-0.6656-24.17152-0.9984-35.50208-0.9984h-50.49856v28.00128l96-0.9984v50.49856a832.8192 832.8192 0 0 0-40.4992-0.9984H453.45792c-13.99808 0.3328-27.66848 0.67072-41.00096 0.9984v-50.50368z m15.49824 162.00192l-1.50016-95.0016 51.99872 2.00192h108.00128l52.50048-2.00192-1.50016 51.50208 1.50016 95.49824-52.50048-2.00192H477.46048l-51.00032 2.00192 1.50016-51.99872z m152.4992 0.9984v-44.49792H482.4576v44.49792h98.00192z',
                                onclick: function () {
                                    flushHis('week');
                                }
                            },
                            myChangeMonthK: {
                                show: curType !== 'month',
                                title: '月K线',
                                icon: 'path://M425.544098 195.814269h170.070384c14.165619 0 25.489817-14.170804 25.489817-28.341607 0-17.027779-11.324199-28.346792-25.489817-28.346792h-170.070384c-14.170804 0-25.489817 14.170804-25.489817 28.346792 0 17.027779 11.319014 28.341607 25.489817 28.341607z m255.105575 31.198582c17.027779 0 28.346792-11.313829 28.346793-22.632842V113.636052c0-14.170804-11.319014-22.632842-28.346793-22.632842s-28.341607 11.313829-28.341607 22.632842v90.635071c0 14.175989 14.165619 22.741729 28.341607 22.741728z M782.603757 136.268895h-17.027778c-17.027779 0-28.346792 14.170804-28.346793 28.346792 0 17.027779 14.170804 28.341607 28.346793 28.341607h17.027778c53.836609 0 102.06297 42.517596 102.06297 99.205995v478.893311c0 53.831424-45.369386 99.21118-102.06297 99.211181H249.76495c-53.831424 0-102.06297-45.379756-102.06297-99.211181V295.020264c0-53.831424 45.369386-99.205995 99.205995-99.205995 17.027779 0 28.346792-14.170804 28.346792-28.341607 0-17.027779-11.319014-28.346792-28.346792-28.346792-84.926305-2.856975-155.785508 68.002228-155.785508 155.894394v478.898496c0 87.886982 70.864388 158.75137 158.75137 158.75137h535.58171c87.892167 0 158.75137-70.864388 158.75137-158.75137V295.020264c-2.85179-87.892167-73.710993-158.75137-161.60316-158.751369z M340.508907 227.012851c17.027779 0 28.346792-11.313829 28.346792-22.632842V113.636052c0-14.170804-14.170804-22.632842-28.346792-22.632842-17.027779 0-28.346792 11.313829-28.346792 22.632842v90.635071c0.005185 14.175989 14.175989 22.741729 28.346792 22.741728z m8.570925 507.234919l14.170803 11.324198c2.856975 2.856975 5.71395 2.856975 8.462039 2.856975 2.856975 0 8.456854-2.856975 8.456854-5.71395 31.203767-36.808831 50.979634-85.035192 56.688399-144.585751h195.555015v96.34902c0 8.462039-2.856975 8.462039-5.71395 8.462039h-62.293463c-5.71395 0-8.462039 2.856975-11.319013 5.719135-2.856975 2.856975-2.856975 8.456854-2.856975 11.313828l5.71395 14.170804c2.856975 5.71395 8.462039 8.462039 14.170803 8.462039h62.293463c28.346792 0 42.517596-17.032964 42.517596-45.374571v-354.088612c0-8.462039-5.719135-14.170804-14.170803-14.170804H408.625206c-8.456854 0-14.170804 5.71395-14.170803 14.170804v221.044832c0 62.293463-17.027779 110.519824-48.231546 150.18563-2.856975 5.708765-2.856975 14.165619 2.856975 19.874384z m93.492045-362.763239h192.69804v70.864388H442.571877V371.484531z m0 113.381984h192.69804v70.859203H442.571877V484.866515z',
                                onclick: function () {
                                    flushHis('month');
                                }
                            },
                            myChangeYearK: {
                                show: curType !== 'year',
                                title: '年K线',
                                icon: 'path://M425.544098 195.814269h170.070384c14.165619 0 25.489817-14.170804 25.489817-28.341607 0-17.027779-11.324199-28.346792-25.489817-28.346792h-170.070384c-14.170804 0-25.489817 14.170804-25.489817 28.346792 0 17.027779 11.319014 28.341607 25.489817 28.341607z m255.105575 31.198582c17.022594 0 28.346792-11.313829 28.346793-22.632842V113.636052c0-14.170804-11.324199-22.632842-28.346793-22.632842-17.032964 0-28.346792 11.313829-28.346792 22.632842v90.635071c0.005185 14.175989 14.170804 22.741729 28.346792 22.741728z M782.603757 136.268895h-17.022593c-17.027779 0-28.346792 14.170804-28.346793 28.346792 0 17.027779 14.165619 28.341607 28.346793 28.341607h17.022593c53.836609 0 102.068155 42.517596 102.068156 99.205995v478.893311c0 53.831424-45.369386 99.21118-102.068156 99.211181H249.76495c-53.831424 0-102.06297-45.379756-102.06297-99.211181V295.020264c0-53.831424 45.369386-99.205995 99.205995-99.205995 17.027779 0 28.346792-14.170804 28.346792-28.341607 0-17.027779-11.319014-28.346792-28.346792-28.346792-84.926305-2.856975-155.785508 68.002228-155.785508 155.894394v478.898496c0 87.886982 70.864388 158.75137 158.75137 158.75137h535.58171c87.892167 0 158.75137-70.864388 158.75137-158.75137V295.020264c-2.85179-87.892167-73.710993-158.75137-161.60316-158.751369z M340.508907 227.012851c17.027779 0 28.346792-11.313829 28.346792-22.632842V113.636052c0-14.170804-14.170804-22.632842-28.346792-22.632842-17.027779 0-28.346792 11.313829-28.346792 22.632842v90.635071c0.005185 14.175989 14.175989 22.741729 28.346792 22.741728zM320.421935 428.634402c18.780333-19.96253 39.344331-49.916695 61.67644-89.86768 12.910831-27.009043 26.4335-38.768788 40.526528-35.242939 17.618877 3.525849 24.670576 13.517484 21.144726 29.954165-1.187382 2.369578-2.945121 4.708046-5.288774 7.046514-2.369578 5.895428-3.525849 9.416092-3.52585 10.572363h248.458312c16.43668 1.187382 25.246119 9.99682 26.433501 26.433501 0 17.618877-8.233895 26.4335-24.670576 26.4335h-121.584769v54.624741h114.538255c14.098213 1.187382 22.300998 9.416092 24.670576 24.670575-1.187382 16.467791-8.809438 24.670576-22.907651 24.670576h-116.30118v86.34183h132.157132c14.098213 1.187382 21.144726 9.99682 21.144726 26.4335-1.187382 16.467791-8.809438 24.670576-22.907651 24.670576h-130.394207v59.913515c-1.187382 14.098213-9.99682 21.720269-26.4335 22.907651-17.618877 0-26.4335-7.046514-26.433501-21.144727v-61.676439H327.468449c-15.280409 0-23.514305-8.202785-24.670576-24.670576 1.156271-16.43668 9.390167-25.246119 24.670576-26.4335h40.526528V500.883204c-2.369578-29.347511 12.910831-43.445724 45.815302-42.289452H510.729657V403.963826H406.763765c-16.462606 28.196425-33.480014 49.341151-51.098891 63.434179-16.462606 11.759745-30.560818 12.335288-42.289452 1.762925-9.416092-11.723449-7.051699-25.246119 7.046513-40.526528z m98.677118 91.630604v74.006542H510.729657V507.929718H431.434341c-9.416092 1.182197-13.517484 5.283589-12.335288 12.335288z',
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
                            this.$http.get('http://127.0.0.1:8088/get_rt$' + stockId).then(function (res) {
                                dataRt = handleRtData(res.body.data, res.body.basePrice);
                                flushOptionRt();
                                myChart.setOption(optionRt, true);
                            }, function () {
                                console.log('请求失败处理');
                            });
                        }
                    }
                });
                vm.get();
                curType = 'rt';
            }

            function flushHis(interval) {
                const vm = new Vue({
                    methods: {
                        get: function () {
                            this.$http.get('http://127.0.0.1:8088/get_his$' + stock_id + '$' + interval).then(function (res) {
                                dataHis = handleHistoryData(res.body.data);
                                flushOptionHis();
                                myChart.setOption(optionHis, true);
                            }, function () {
                                console.log('请求失败处理');
                            });
                        }
                    }
                });
                vm.get();
                curType = interval;
            }

            this.show = function () {
                flushRt();
            };

            this.flushData = function () {
                if (curType === 'rt') {
                    flushRt();
                }
                console.log(Date.now());
            }
        }

    )
;