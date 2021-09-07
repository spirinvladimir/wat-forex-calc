function price_by_amount_js (orderbook, amount, count) {
    var sum = 0
    var i = 0
    var order
    var price = null
    do {
        order = {
            price: orderbook[i * 2],
            amount: orderbook[i * 2 + 1]
        }
        price = order.price
        sum += order.amount
        i++
    } while (i < count && sum < amount)

    return sum < amount
        ? null
        : price
}

function debounce (func) {
    let debounceTimer
    return function() {
        const context = this
        const args = arguments
        clearTimeout(debounceTimer)
        debounceTimer = setTimeout(() => func.apply(context, args), 500)
    }
}

const tbody = document.getElementsByTagName('tbody')[0]
const memory = new WebAssembly.Memory({initial: 1, maximum: 10})

fetch('main.wasm')
    .then(_ => _.arrayBuffer())
    .then(_ => WebAssembly.instantiate(_, {js: {mem: memory}}))
    .then(_ => {
        const {price_by_amount} = _.instance.exports
        const orderbook = new Float64Array(memory.buffer)

        const load_orderbook = debounce(() => {
            for (var i = 0; i < tbody.children.length; i += 1) {
                orderbook[i * 2]     = Number(tbody.children[i].firstElementChild.firstElementChild.value)
                orderbook[i * 2 + 1] = Number(tbody.children[i].lastElementChild.firstElementChild.value)
            }
        })

        const find_best_price_for_amount = debounce(() =>
            input_price.value = js.checked
                ? price_by_amount_js(orderbook, Number(input_amount.value), tbody.children.length)
                : price_by_amount(Number(input_amount.value), tbody.children.length)
        )

        Array.prototype.forEach.call(
            document.getElementsByTagName('input'),
            input => {
                if (input.id === 'input_amount') {
                    input.onkeyup = find_best_price_for_amount
                    input.onchange = find_best_price_for_amount
                }
                input.onkeyup = load_orderbook
                input.onchange = load_orderbook
            }
        )

        load_orderbook()
    })
    .catch(console.error)
