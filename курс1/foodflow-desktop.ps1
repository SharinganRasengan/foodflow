Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

# Local demo data for the desktop control panel.
$orders = @(
    [PSCustomObject]@{
        Id = "#FF-1024"
        Customer = "Anna Smirnova"
        Address = "Lesnaya 14"
        Status = "Cooking"
        ETA = "18 min"
        Courier = "Ilya"
        Items = "Tom Yum, Salmon Roll, Mango Lemonade"
    }
    [PSCustomObject]@{
        Id = "#FF-1025"
        Customer = "Maxim Orlov"
        Address = "Pobedy 7"
        Status = "With courier"
        ETA = "11 min"
        Courier = "Sofia"
        Items = "BBQ Burger, Fries, Cola"
    }
    [PSCustomObject]@{
        Id = "#FF-1026"
        Customer = "Elena Petrova"
        Address = "Rechnaya 22"
        Status = "Urgent"
        ETA = "9 min"
        Courier = "Artur"
        Items = "Tuna Poke, Miso Soup"
    }
)

$workers = @(
    [PSCustomObject]@{
        Name = "Sofia Belova"
        Role = "Courier"
        Shift = "08:00 - 20:00"
        Load = 82
        Task = "3 active deliveries"
    }
    [PSCustomObject]@{
        Name = "Danil Mironov"
        Role = "Operator"
        Shift = "09:00 - 21:00"
        Load = 56
        Task = "Processing incoming calls"
    }
    [PSCustomObject]@{
        Name = "Maria Volkova"
        Role = "Kitchen"
        Shift = "10:00 - 22:00"
        Load = 74
        Task = "Hot kitchen supervision"
    }
    [PSCustomObject]@{
        Name = "Ilya Gromov"
        Role = "Courier"
        Shift = "07:00 - 19:00"
        Load = 67
        Task = "2 orders on route"
    }
)

$comments = @(
    [PSCustomObject]@{
        Time = "12:05"
        Author = "Operator Anton"
        Text = "Customer for #FF-1024 requested extra cutlery and sauce."
    }
    [PSCustomObject]@{
        Time = "12:11"
        Author = "Kitchen"
        Text = "Roll prep is complete, hot menu has no delays right now."
    }
    [PSCustomObject]@{
        Time = "12:16"
        Author = "Logistics"
        Text = "Heavy traffic in the north district may add 5-7 minutes."
    }
)

function New-SectionLabel {
    param(
        [string]$Text,
        [int]$X,
        [int]$Y,
        [int]$Width = 300,
        [int]$Height = 32,
        [float]$FontSize = 16
    )

    $label = New-Object System.Windows.Forms.Label
    $label.Text = $Text
    $label.Location = New-Object System.Drawing.Point($X, $Y)
    $label.Size = New-Object System.Drawing.Size($Width, $Height)
    $label.Font = New-Object System.Drawing.Font("Segoe UI Semibold", $FontSize, [System.Drawing.FontStyle]::Bold)
    $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#221B17")
    return $label
}

function New-InfoCard {
    param(
        [string]$Title,
        [string]$Value,
        [string]$Note,
        [int]$X,
        [int]$Y
    )

    $panel = New-Object System.Windows.Forms.Panel
    $panel.Location = New-Object System.Drawing.Point($X, $Y)
    $panel.Size = New-Object System.Drawing.Size(230, 96)
    $panel.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#FFF8F1")
    $panel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Text = $Title
    $titleLabel.Location = New-Object System.Drawing.Point(14, 12)
    $titleLabel.Size = New-Object System.Drawing.Size(190, 18)
    $titleLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#8A6A4D")
    $titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)

    $valueLabel = New-Object System.Windows.Forms.Label
    $valueLabel.Text = $Value
    $valueLabel.Location = New-Object System.Drawing.Point(14, 30)
    $valueLabel.Size = New-Object System.Drawing.Size(190, 34)
    $valueLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 20, [System.Drawing.FontStyle]::Bold)
    $valueLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#D35400")

    $noteLabel = New-Object System.Windows.Forms.Label
    $noteLabel.Text = $Note
    $noteLabel.Location = New-Object System.Drawing.Point(14, 66)
    $noteLabel.Size = New-Object System.Drawing.Size(200, 18)
    $noteLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#6C5A4C")
    $noteLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8.5)

    $panel.Controls.AddRange(@($titleLabel, $valueLabel, $noteLabel))
    return $panel
}

# Main desktop window.
$form = New-Object System.Windows.Forms.Form
$form.Text = "FoodFlow Desktop"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(1280, 860)
$form.MinimumSize = New-Object System.Drawing.Size(1180, 760)
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#FFF4E8")
$form.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)

$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Location = New-Object System.Drawing.Point(16, 16)
$headerPanel.Size = New-Object System.Drawing.Size(1230, 170)
$headerPanel.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#FFE3C2")

$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "Food delivery control panel"
$titleLabel.Location = New-Object System.Drawing.Point(24, 20)
$titleLabel.Size = New-Object System.Drawing.Size(560, 44)
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 24, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#1F1A17")

$subtitleLabel = New-Object System.Windows.Forms.Label
$subtitleLabel.Text = "Desktop app with orders, workers and team comments."
$subtitleLabel.Location = New-Object System.Drawing.Point(26, 70)
$subtitleLabel.Size = New-Object System.Drawing.Size(520, 26)
$subtitleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$subtitleLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#5F5249")

$newOrderButton = New-Object System.Windows.Forms.Button
$newOrderButton.Text = "New order"
$newOrderButton.Location = New-Object System.Drawing.Point(26, 112)
$newOrderButton.Size = New-Object System.Drawing.Size(150, 38)
$newOrderButton.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#E46E1B")
$newOrderButton.ForeColor = [System.Drawing.Color]::White
$newOrderButton.FlatStyle = "Flat"
$newOrderButton.FlatAppearance.BorderSize = 0

$shiftButton = New-Object System.Windows.Forms.Button
$shiftButton.Text = "Open shift"
$shiftButton.Location = New-Object System.Drawing.Point(188, 112)
$shiftButton.Size = New-Object System.Drawing.Size(150, 38)
$shiftButton.BackColor = [System.Drawing.Color]::White
$shiftButton.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#352A22")
$shiftButton.FlatStyle = "Flat"
$shiftButton.FlatAppearance.BorderColor = [System.Drawing.ColorTranslator]::FromHtml("#D9C3AC")

$headerPanel.Controls.AddRange(@($titleLabel, $subtitleLabel, $newOrderButton, $shiftButton))
$headerPanel.Controls.Add((New-InfoCard -Title "Orders today" -Value "184" -Note "+12% vs yesterday" -X 690 -Y 22))
$headerPanel.Controls.Add((New-InfoCard -Title "Avg delivery time" -Value "27 min" -Note "Target under 30 min" -X 930 -Y 22))
$headerPanel.Controls.Add((New-InfoCard -Title "Couriers online" -Value "14" -Note "2 workers in reserve" -X 690 -Y 118))

$ordersLabel = New-SectionLabel -Text "Active orders" -X 24 -Y 202
$workersLabel = New-SectionLabel -Text "Workers on shift" -X 820 -Y 202
$commentsLabel = New-SectionLabel -Text "Comments" -X 24 -Y 520

# Order table for desktop layout.
$ordersGrid = New-Object System.Windows.Forms.DataGridView
$ordersGrid.Location = New-Object System.Drawing.Point(20, 240)
$ordersGrid.Size = New-Object System.Drawing.Size(760, 250)
$ordersGrid.BackgroundColor = [System.Drawing.Color]::White
$ordersGrid.BorderStyle = "None"
$ordersGrid.AllowUserToAddRows = $false
$ordersGrid.AllowUserToDeleteRows = $false
$ordersGrid.AllowUserToResizeRows = $false
$ordersGrid.ReadOnly = $true
$ordersGrid.RowHeadersVisible = $false
$ordersGrid.SelectionMode = "FullRowSelect"
$ordersGrid.MultiSelect = $false
$ordersGrid.AutoSizeColumnsMode = "Fill"
$ordersGrid.ColumnHeadersHeight = 38
$ordersGrid.EnableHeadersVisualStyles = $false
$ordersGrid.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#F7D8B0")
$ordersGrid.ColumnHeadersDefaultCellStyle.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#2E241E")
$ordersGrid.ColumnHeadersDefaultCellStyle.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 9.5, [System.Drawing.FontStyle]::Bold)
$ordersGrid.DefaultCellStyle.SelectionBackColor = [System.Drawing.ColorTranslator]::FromHtml("#FFE6C7")
$ordersGrid.DefaultCellStyle.SelectionForeColor = [System.Drawing.ColorTranslator]::FromHtml("#241B15")
$ordersGrid.DefaultCellStyle.BackColor = [System.Drawing.Color]::White
$ordersGrid.DefaultCellStyle.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#3D3129")
$ordersGrid.GridColor = [System.Drawing.ColorTranslator]::FromHtml("#E9D4C0")

[void]$ordersGrid.Columns.Add("Id", "Order")
[void]$ordersGrid.Columns.Add("Customer", "Customer")
[void]$ordersGrid.Columns.Add("Address", "Address")
[void]$ordersGrid.Columns.Add("Status", "Status")
[void]$ordersGrid.Columns.Add("ETA", "ETA")
[void]$ordersGrid.Columns.Add("Courier", "Courier")

foreach ($order in $orders) {
    [void]$ordersGrid.Rows.Add($order.Id, $order.Customer, $order.Address, $order.Status, $order.ETA, $order.Courier)
}

# Worker roster panel.
$workersList = New-Object System.Windows.Forms.ListView
$workersList.Location = New-Object System.Drawing.Point(816, 240)
$workersList.Size = New-Object System.Drawing.Size(430, 250)
$workersList.View = "Details"
$workersList.FullRowSelect = $true
$workersList.GridLines = $false
$workersList.HideSelection = $false
$workersList.HeaderStyle = "Nonclickable"
$workersList.BackColor = [System.Drawing.Color]::White

[void]$workersList.Columns.Add("Worker", 150)
[void]$workersList.Columns.Add("Role", 90)
[void]$workersList.Columns.Add("Shift", 90)
[void]$workersList.Columns.Add("Load", 80)

foreach ($worker in $workers) {
    $item = New-Object System.Windows.Forms.ListViewItem($worker.Name)
    [void]$item.SubItems.Add($worker.Role)
    [void]$item.SubItems.Add($worker.Shift)
    [void]$item.SubItems.Add("$($worker.Load)%")
    [void]$workersList.Items.Add($item)
}

# Right side detail card for the selected worker.
$workerDetailsPanel = New-Object System.Windows.Forms.Panel
$workerDetailsPanel.Location = New-Object System.Drawing.Point(816, 500)
$workerDetailsPanel.Size = New-Object System.Drawing.Size(430, 268)
$workerDetailsPanel.BackColor = [System.Drawing.Color]::White
$workerDetailsPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$workerNameLabel = New-SectionLabel -Text "Sofia Belova" -X 18 -Y 18 -Width 260 -Height 32 -FontSize 15
$workerRoleLabel = New-Object System.Windows.Forms.Label
$workerRoleLabel.Text = "Courier"
$workerRoleLabel.Location = New-Object System.Drawing.Point(20, 50)
$workerRoleLabel.Size = New-Object System.Drawing.Size(220, 22)
$workerRoleLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#7A6555")

$workerTaskLabel = New-Object System.Windows.Forms.Label
$workerTaskLabel.Text = "3 active deliveries"
$workerTaskLabel.Location = New-Object System.Drawing.Point(20, 88)
$workerTaskLabel.Size = New-Object System.Drawing.Size(340, 22)
$workerTaskLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 10.5, [System.Drawing.FontStyle]::Bold)

$workerShiftLabel = New-Object System.Windows.Forms.Label
$workerShiftLabel.Text = "Shift: 08:00 - 20:00"
$workerShiftLabel.Location = New-Object System.Drawing.Point(20, 120)
$workerShiftLabel.Size = New-Object System.Drawing.Size(250, 22)

$workerLoadTitle = New-Object System.Windows.Forms.Label
$workerLoadTitle.Text = "Current load"
$workerLoadTitle.Location = New-Object System.Drawing.Point(20, 156)
$workerLoadTitle.Size = New-Object System.Drawing.Size(200, 20)
$workerLoadTitle.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#7A6555")

$workerLoadBar = New-Object System.Windows.Forms.ProgressBar
$workerLoadBar.Location = New-Object System.Drawing.Point(20, 184)
$workerLoadBar.Size = New-Object System.Drawing.Size(380, 22)
$workerLoadBar.Style = "Continuous"
$workerLoadBar.Maximum = 100
$workerLoadBar.Value = 82

$workerLoadValue = New-Object System.Windows.Forms.Label
$workerLoadValue.Text = "82%"
$workerLoadValue.Location = New-Object System.Drawing.Point(20, 214)
$workerLoadValue.Size = New-Object System.Drawing.Size(100, 22)
$workerLoadValue.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 10, [System.Drawing.FontStyle]::Bold)

$workerDetailsPanel.Controls.AddRange(@(
    $workerNameLabel,
    $workerRoleLabel,
    $workerTaskLabel,
    $workerShiftLabel,
    $workerLoadTitle,
    $workerLoadBar,
    $workerLoadValue
))

# Comments feed.
$commentsBox = New-Object System.Windows.Forms.ListBox
$commentsBox.Location = New-Object System.Drawing.Point(20, 558)
$commentsBox.Size = New-Object System.Drawing.Size(760, 210)
$commentsBox.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$commentsBox.BackColor = [System.Drawing.Color]::White
$commentsBox.BorderStyle = "FixedSingle"

foreach ($comment in $comments) {
    [void]$commentsBox.Items.Add("[$($comment.Time)] $($comment.Author): $($comment.Text)")
}

# Order detail strip under the table.
$orderDetailsPanel = New-Object System.Windows.Forms.Panel
$orderDetailsPanel.Location = New-Object System.Drawing.Point(20, 500)
$orderDetailsPanel.Size = New-Object System.Drawing.Size(760, 52)
$orderDetailsPanel.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#FFF9F3")
$orderDetailsPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$orderDetailsLabel = New-Object System.Windows.Forms.Label
$orderDetailsLabel.Text = "Order items: select a row in the table above."
$orderDetailsLabel.Location = New-Object System.Drawing.Point(14, 14)
$orderDetailsLabel.Size = New-Object System.Drawing.Size(720, 24)
$orderDetailsLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)

$orderDetailsPanel.Controls.Add($orderDetailsLabel)

# Update order details when the user selects an order.
$ordersGrid.Add_SelectionChanged({
    if ($ordersGrid.SelectedRows.Count -gt 0) {
        $selectedId = $ordersGrid.SelectedRows[0].Cells[0].Value
        $selectedOrder = $orders | Where-Object { $_.Id -eq $selectedId } | Select-Object -First 1
        if ($null -ne $selectedOrder) {
            $orderDetailsLabel.Text = "Order items for $($selectedOrder.Id): $($selectedOrder.Items)"
        }
    }
})

# Update worker details when the user picks a worker in the list.
$workersList.Add_SelectedIndexChanged({
    if ($workersList.SelectedItems.Count -gt 0) {
        $selectedName = $workersList.SelectedItems[0].Text
        $selectedWorker = $workers | Where-Object { $_.Name -eq $selectedName } | Select-Object -First 1
        if ($null -ne $selectedWorker) {
            $workerNameLabel.Text = $selectedWorker.Name
            $workerRoleLabel.Text = $selectedWorker.Role
            $workerTaskLabel.Text = $selectedWorker.Task
            $workerShiftLabel.Text = "Shift: $($selectedWorker.Shift)"
            $workerLoadBar.Value = $selectedWorker.Load
            $workerLoadValue.Text = "$($selectedWorker.Load)%"
        }
    }
})

# Placeholder button actions for future project growth.
$newOrderButton.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        "This button can open a real new-order form later.",
        "New order",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
})

$shiftButton.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        "Shift opened. Business logic can be added later.",
        "Shift",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
})

$form.Controls.AddRange(@(
    $headerPanel,
    $ordersLabel,
    $workersLabel,
    $commentsLabel,
    $ordersGrid,
    $workersList,
    $workerDetailsPanel,
    $orderDetailsPanel,
    $commentsBox
))

[void]$form.ShowDialog()
