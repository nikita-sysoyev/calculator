defmodule CalculatorWeb.ApiControllerTest do
  use CalculatorWeb.ConnCase
  import Calculator.Factory

  test "GET /api/calculate", %{conn: conn} do
  	btc = insert(:currency, %{name: "Bitcoin", code: "BTC"})
    past_time = Timex.shift(DateTime.utc_now, hours: -5)
  	insert(:rate, %{value: 1.1, currency: btc})
    insert(:rate, %{value: 1.0, currency: btc, inserted_at: past_time})

  	eth = insert(:currency, %{name: "Etherium", code: "ETH"})
  	insert(:rate, %{value: 3.5, currency: eth})

    insert(:currency, %{name: "Bitcoin Cash", code: "BTH"})

    conn = get conn, "/api/calculate?currency=DGC&value=4"
    assert json_response(conn, 500) == %{
      "errors" => "wrong currency code"
    }

    conn = get conn, "/api/calculate?currency=BTH&value=4"
    assert json_response(conn, 500) == %{
      "errors" => "rate data unavailable"
    }

    conn = get conn, "/api/calculate?currency=BTC&value=4"
    assert json_response(conn, 200) == %{
      "value" => 4.4,
      "success" => true
    }

    conn = get conn, "/api/calculate?currency=ETH&value=1"
    assert json_response(conn, 200) == %{
      "value" => 3.5,
      "success" => true
    }

    past_time_text = past_time |> DateTime.to_time |> Time.to_string
    conn = get conn, "/api/calculate?currency=BTC&value=4&time=#{past_time_text}"
    assert json_response(conn, 200) == %{
      "value" => 4.0,
      "success" => true
    }
  end
end
