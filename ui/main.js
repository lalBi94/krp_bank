$(function () {
    function display(bool) {
        if(bool) {
            $("#container").show()
        } else {
            $("#container").hide()
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        const zod = event.data;

        const client = document.getElementById("client")
        const balance = document.getElementById("balance")
        const accountn = document.getElementById("accountn")
        
        const deposit = document.getElementById("deposit")
        const withdraw = document.getElementById("withdraw")
        const curAction = document.getElementById("cur-action")
        const pad = document.getElementById("pad")
        const curAmount = document.getElementById("cur-amount")
        const titleAction = document.getElementById("title-action")
        const back = document.getElementById("back")
        const remove = document.getElementById("remove")

        const transfer = document.getElementById("transfer")
        const transferMenu = document.getElementById("transfer-frame")
        const tranferCancel = document.getElementById("transfer-cancel")

        back.addEventListener("click", () => {
            curAction.style.display = "none"
            pad.style.display = "none"
        })

        remove.addEventListener("click", () => {
            curAmount.innerText = ""
        })

        deposit.addEventListener("click", () => {
            curAction.style.display = "flex"
            pad.style.display = "flex"
            transferMenu.style.display = "none"
            titleAction.innerText = "DEPOT"
        })

        withdraw.addEventListener("click", () => {
            curAction.style.display = "flex"
            pad.style.display = "flex"
            transferMenu.style.display = "none"
            titleAction.innerText = "RETRAIT"
        })

        tranferCancel.addEventListener("click", () => {
            curAction.style.display = "none"
            pad.style.display = "none"
            transferMenu.style.display = "none"
        })

        transfer.addEventListener("click", () => {
            transferMenu.style.display = "flex"
        })

        if (zod.type === "ui") {
            if (zod.status) {
                client.innerText = zod.client
                balance.innerText = zod.balance
                accountn.innerText = zod.naccount

                display(true)
            } else {
                display(false)
            }
        }
    })
    
    document.onkeyup = function (data) {
        if (data.which === 27) {
            $.post('http://krp_bank/exit', JSON.stringify({}));
            return true
        }
    }

    $(document).ready(function() {
        const allButtonsPad = $("#container > #pad > #pad-numbers > button");
        const curAmount = $("#cur-amount");

        allButtonsPad.each(function() {
            $(this).click(function() {
                if (curAmount.text().length <= 9) {
                    curAmount.text(curAmount.text() + $(this).text());
                }
            });
        });
    })

    $("#transfer-ok").click(() => {
        const transferMenu = document.getElementById("transfer-frame")
        const transferAccountn = document.getElementById("tranfer-n-account")
        const transferAmount = document.getElementById("tranfer-amount")

        const naccount = transferAccountn.value
        const amount = transferAmount.value

        transferMenu.style.display = "none"
        transferAccountn.value = ""
        transferAmount.value = ""

        if(naccount &&
            amount >= 1000 &&
            naccount.length === 19) {
            $.post('http://krp_bank/transfer', JSON.stringify({naccount: naccount, amount: amount}));
        } else {
            $.post("http://krp_bank/error", JSON.stringify(
                {msg: "~r~Le numero bancaire doit ressembler a : XXXX-XXXX-XXXX-XXXX \n\n Le montant doit etre superieur a 1000"}
            ))
        }
    })

    $("#validate").click(() => {
        const titleAction = document.getElementById("title-action")
        const curAmount = document.getElementById("cur-amount")
        const method = titleAction.innerText
        const value = parseInt(curAmount.innerText)

        $("#cur-amount").text("")
        $("#cur-action").hide()
        $("#pad").hide()

        $.post('http://krp_bank/submit', JSON.stringify({method: method, value: value}));
    })

    $("#exit").click(() => {
        $("#cur-amount").text("")
        $.post('http://krp_bank/exit', JSON.stringify({}));
    })

    $("#discord-logo").click(() => {
        const discord = "https://discord.gg/t3ZxqJJAAH"

        const copyToClipboard = (str) => {
            const el = document.createElement('textarea')
            el.value = str
            document.body.appendChild(el)
            el.select()
            document.execCommand('copy')
            document.body.removeChild(el)
        }

        copyToClipboard(discord)

        $.post('http://krp_bank/discord', JSON.stringify({}));
    })
})