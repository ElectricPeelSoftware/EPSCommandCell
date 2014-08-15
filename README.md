# EPSCommandCell

## Usage

Set up the cell with a command:

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EPSCommandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = "Some Text";
    cell.command = self.someCommand;
    return cell;
}
```

Make sure the cell can’t be tapped when its command is disabled:

```objective-c
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    EPSCommandCell *cell = (EPSCommandCell *)[tableView cellForRowAtIndexPath:indexPath];
    return cell.canExecuteCommand;
}
```

When the cell is tapped, execute its command:

```objective-c
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EPSCommandCell *cell = (EPSCommandCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.command execute:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
```

## Installation

EPSCommandCell is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EPSCommandCell"
```

## License

EPSCommandCell is available under the MIT license. See the LICENSE file for more info.
