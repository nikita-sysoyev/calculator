defmodule CalculatorWeb.PageControllerTest do
  use CalculatorWeb.ConnCase
  import Calculator.Factory

  test "GET /", %{conn: conn} do
    btc = insert(:currency, %{name: "Bitcoin", code: "BTC"})
    insert(:rate, %{value: 1.1, currency: btc})

    eth = insert(:currency, %{name: "Etherium", code: "ETH"})
    insert(:rate, %{value: 1.1, currency: eth})

    bth = insert(:currency, %{name: "Bitcoin Cash", code: "BTH"})
    insert(:rate, %{value: 1.1, currency: bth})

    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Latest rates:"
  end
end
