program prjBizInfoCheckExample;

uses
  Forms,
  Example in 'Example.pas' {frmExample},
  Popbill in 'Popbill\Popbill.pas',
  Linkhub in 'Linkhub\Linkhub.pas',
  PopbillBizInfoCheck in 'PopbillBizInfoCheck\PopbillBizInfoCheck.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmExample, frmExample);
  Application.Run;
end.
