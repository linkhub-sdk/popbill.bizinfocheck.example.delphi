{******************************************************************************}
{ �˺� ���������ȸ API Delphi SDK Example
{
{ - ������ SDK ������ �ȳ� : https://developers.popbill.com/guide/bizinfocheck/delphi/getting-started/tutorial
{ - ������Ʈ ���� : 2022-10-05
{ - ���� ������� ����ó : 1600-9854
{ - ���� ������� �̸��� : code@linkhubcorp.com
{
{ <�׽�Ʈ �������� �غ����>
{ (1) 31, 34�� ���ο� ����� ��ũ���̵�(LinkID)�� ���Ű(SecretKey)��
{    ��ũ��� ���Խ� ���Ϸ� �߱޹��� ���������� ����
{
{******************************************************************************}

unit Example;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Popbill, PopbillBizInfoCheck;

const
        {**********************************************************************}
        { - ��������(��ũ���̵�, ���Ű)�� ��Ʈ���� ����ȸ���� �ĺ��ϴ�        }
        {   ������ ���ǹǷ� ������� �ʵ��� �����Ͻñ� �ٶ��ϴ�              }
        { - ����� ��ȯ���Ŀ��� ���������� ������� �ʽ��ϴ�.                  }
        {**********************************************************************}

         //��ũ���̵�.
        LinkID = 'TESTER';

        // ��Ʈ�� ��ſ� ���Ű. ���� ����.
        SecretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I=';
type
  TfrmExample = class(TForm)
    btnGetUnitCost: TButton;
    txtCorpNum: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtUserID: TEdit;
    btnJoinMember: TButton;
    btnCheckIsMember: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnGetAccessURL: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    txtCheckCorpNum: TEdit;
    Label3: TLabel;
    btnCheckBizInfo: TButton;
    btnCheckID: TButton;
    GroupBox6: TGroupBox;
    btnRegistContact: TButton;
    btnListContact: TButton;
    btnUpdateContact: TButton;
    btnGetCorpInfo: TButton;
    btnUpdateCorpInfo: TButton;
    GroupBox7: TGroupBox;
    btnGetChargeInfo: TButton;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    btnGetBalance: TButton;
    btnGetChargeURL: TButton;
    btnGetPartnerPoint: TButton;
    btnGetPartnerURL_CHRG: TButton;
    btnGetPaymentURL: TButton;
    btnGetUseHistoryURL: TButton;
    btnGetContactInfo: TButton;
    txtURL: TEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action:TCloseAction);
    procedure btnCheckBizInfoClick(Sender: TObject);
    procedure btnJoinMemberClick(Sender: TObject);
    procedure btnCheckIsMemberClick(Sender: TObject);
    procedure btnGetBalanceClick(Sender: TObject);
    procedure btnGetUnitCostClick(Sender: TObject);
    procedure btnGetAccessURLClick(Sender: TObject);
    procedure btnGetChargeURLClick(Sender: TObject);
    procedure btnGetPartnerPointClick(Sender: TObject);
    procedure btnCheckIDClick(Sender: TObject);
    procedure btnRegistContactClick(Sender: TObject);
    procedure btnListContactClick(Sender: TObject);
    procedure btnUpdateContactClick(Sender: TObject);
    procedure btnGetCorpInfoClick(Sender: TObject);
    procedure btnUpdateCorpInfoClick(Sender: TObject);
    procedure btnGetChargeInfoClick(Sender: TObject);
    procedure btnGetPartnerURL_CHRGClick(Sender: TObject);
    procedure btnGetPaymentURLClick(Sender: TObject);
    procedure btnGetUseHistoryURLClick(Sender: TObject);
    procedure btnGetContactInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExample: TfrmExample;
  bizInfoCheckService : TBizInfoCheckService;

implementation

{$R *.DFM}

procedure TfrmExample.FormCreate(Sender: TObject);
begin
        //���������ȸ ��� �ʱ�ȭ.
        bizInfoCheckService := TBizInfoCheckService.Create(LinkID,SecretKey);

        // ����ȯ�� ����, true-���߿�, false-�����
        bizInfoCheckService.IsTest := true;

        // Exception ó�� ����, true-���, false-�̻��, �⺻��(true)
        bizInfoCheckService.IsThrowException := true;

        // ������ū IP���ѱ�� ��뿩��, true-���, false-�̻��, �⺻��(true)
        bizInfoCheckService.IPRestrictOnOff := true;

        //���ýý��� �ð� ��뿩��, true-���, false-�̻��, �⺻��(true)
        bizInfoCheckService.UseLocalTimeYN := false;
end;

function BoolToStr(b:Boolean):String;
begin
    if b = true then BoolToStr:='True';
    if b = false then BoolToStr:='False';
end;

procedure TfrmExample.FormClose(Sender: TObject; var Action:TCloseAction);
begin
        bizInfoCheckService.Free;
        Action := caFree;
end;


procedure TfrmExample.btnCheckBizInfoClick(Sender: TObject);
var
        bizCheckInfo : TBizCheckInfo;
        tmp : string;
begin
        {**********************************************************************}
        { ����ڹ�ȣ 1�ǿ� ���� ��������� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/check#CheckBizInfo
        {**********************************************************************}

        try
                bizCheckInfo := bizInfoCheckService.checkBizInfo(txtCorpNum.Text, txtCheckCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage(IntToStr(le.code) + ' | ' +  le.Message);
                        Exit;
                end;
        end;

        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                tmp := 'corpNum (����ڹ�ȣ) : ' + bizCheckInfo.corpNum + #13;
                tmp := tmp + 'companyRegNum (���ι�ȣ): ' + bizCheckInfo.companyRegNum + #13;
                tmp := tmp + 'checkDT (Ȯ���Ͻ�) : ' + bizCheckInfo.checkDT + #13;
                tmp := tmp + 'corpName (��ȣ): ' + bizCheckInfo.corpName + #13;
                tmp := tmp + 'corpCode (��������ڵ�): ' + bizCheckInfo.corpCode + #13;
                tmp := tmp + 'corpScaleCode (����Ը��ڵ�): ' + bizCheckInfo.corpScaleCode + #13;
                tmp := tmp + 'personCorpCode (���ι����ڵ�): ' + bizCheckInfo.personCorpCode + #13;
                tmp := tmp + 'headOfficeCode (���������ڵ�) : ' + bizCheckInfo.headOfficeCode + #13;
                tmp := tmp + 'industryCode (����ڵ�) : ' +bizCheckInfo.industryCode + #13;
                tmp := tmp + 'establishCode (���������ڵ�) : ' + bizCheckInfo.establishCode + #13;
                tmp := tmp + 'establishDate (��������) : ' + bizCheckInfo.establishDate + #13;
                tmp := tmp + 'CEOName (��ǥ�ڸ�) : ' + bizCheckInfo.ceoname + #13;
                tmp := tmp + 'workPlaceCode (����屸���ڵ�): ' + bizCheckInfo.workPlaceCode + #13;
                tmp := tmp + 'addrCode (�ּұ����ڵ�) : ' + bizCheckInfo.addrCode + #13;
                tmp := tmp + 'zipCode (�����ȣ) : ' + bizCheckInfo.zipCode + #13;
                tmp := tmp + 'addr (�ּ�) : ' + bizCheckInfo.addr + #13;
                tmp := tmp + 'addrDetail (���ּ�) : ' + bizCheckInfo.addrDetail + #13;
                tmp := tmp + 'enAddr (�����ּ�) : ' + bizCheckInfo.enAddr + #13;
                tmp := tmp + 'bizClass (����) : ' + bizCheckInfo.bizClass + #13;
                tmp := tmp + 'bizType (����) : ' + bizCheckInfo.bizType + #13;
                tmp := tmp + 'result (����ڵ�) : ' + bizCheckInfo.result + #13;
                tmp := tmp + 'resultMessage (����޽���) : ' + bizCheckInfo.resultMessage + #13;
                tmp := tmp + 'closeDownTaxType (����ڰ�������) : ' + bizCheckInfo.closeDownTaxType + #13;
                tmp := tmp + 'closeDownTaxTypeDate (����������ȯ����):' + bizCheckInfo.closeDownTaxTypeDate + #13;
                tmp := tmp + 'closeDownState (���������) : ' + bizCheckInfo.closeDownState + #13;
                tmp := tmp + 'closeDownStateDate (���������) : ' + bizCheckInfo.closeDownStateDate + #13#13;

                ShowMessage(tmp);
        end;
        
        bizCheckInfo.Free;
end;

procedure TfrmExample.btnJoinMemberClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinForm;
begin
        {**********************************************************************}
        { ����ڸ� ����ȸ������ ����ó���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#JoinMember
        {**********************************************************************}

        // ��ũ���̵�
        joinInfo.LinkID := LinkID;

        // ����ڹ�ȣ '-' ����, 10�ڸ�
        joinInfo.CorpNum := '1234567890';

        // ��ǥ�ڼ���, �ִ� 100��
        joinInfo.CEOName := '��ǥ�ڼ���';

        // ��ȣ��, �ִ� 200��
        joinInfo.CorpName := '��ũ���';

        // �ּ�, �ִ� 300��
        joinInfo.Addr := '�ּ�';

        // ����, �ִ� 100��
        joinInfo.BizType := '����';

        // ����, �ִ� 100��
        joinInfo.BizClass := '����';

        // ���̵�, 6���̻� 50�� �̸�
        joinInfo.ID     := 'userid';

        // ��й�ȣ (8�� �̻� 20�� �̸�) ����, ���� ,Ư������ ����
        joinInfo.Password := 'asdf123!@';

        // ����ڸ�, �ִ� 100��
        joinInfo.ContactName := '����ڸ�';

        // ����� ����ó, �ִ� 20��
        joinInfo.ContactTEL :='070-4304-2991';

        // ����� ����, �ִ� 100��
        joinInfo.ContactEmail := 'code@linkhub.co.kr';

        try
                response := bizInfoCheckService.JoinMember(joinInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('�����ڵ� : ' + IntToStr(response.code) + #10#13 + '����޽��� : '+ response.Message);
        end;
end;

procedure TfrmExample.btnCheckIsMemberClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { ����ڹ�ȣ�� ��ȸ�Ͽ� ����ȸ�� ���Կ��θ� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#CheckIsMember
        {**********************************************************************}

        try
                response := bizInfoCheckService.CheckIsMember(txtCorpNum.text, LinkID);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('�����ڵ� : ' + IntToStr(response.code) + #10#13 + '����޽��� : '+ response.Message);
        end;
end;

procedure TfrmExample.btnGetBalanceClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { ����ȸ���� �ܿ�����Ʈ�� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetBalance
        {**********************************************************************}
        
        try
                balance := bizInfoCheckService.GetBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('�ܿ�����Ʈ : ' + FloatToStr(balance));
        end;

end;

procedure TfrmExample.btnGetUnitCostClick(Sender: TObject);
var
        unitcost : Single;
begin
        {**********************************************************************}
        { ������� ��ȸ�� ���ݵǴ� ����Ʈ �ܰ��� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetUnitCost
        {**********************************************************************}

        try
                unitcost := bizInfoCheckService.GetUnitCost(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;

        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage('�����ڵ� : ' + IntToStr(bizInfoCheckService.LastErrCode) + #10#13 +'����޽��� : '+ bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('��ȸ�ܰ� : '+ FloatToStr(unitcost));
        end;

end;

procedure TfrmExample.btnGetAccessURLClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        { �˺� ����Ʈ�� �α��� ���·� ������ �� �ִ� �������� �˾� URL�� ��ȯ�մϴ�.
        { - ��ȯ�Ǵ� URL�� ���� ��å�� 30�� ���� ��ȿ�ϸ�, �ð��� �ʰ��� �Ŀ��� �ش� URL�� ���� ������ ������ �Ұ��մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#GetAccessURL
        {**********************************************************************}

        try
                resultURL := bizInfoCheckService.getAccessURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL : ' + #13 + resultURL);
        end;
end;

procedure TfrmExample.btnGetChargeURLClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        { ����ȸ�� ����Ʈ ������ ���� �������� �˾� URL�� ��ȯ�մϴ�.
        { - ��ȯ�Ǵ� URL�� ���� ��å�� 30�� ���� ��ȿ�ϸ�, �ð��� �ʰ��� �Ŀ��� �ش� URL�� ���� ������ ������ �Ұ��մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetChargeURL
        {**********************************************************************}
        
        try
                resultURL := bizInfoCheckService.getChargeURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL : ' + #13 + resultURL);
        end;

end;

procedure TfrmExample.btnGetPartnerPointClick(Sender: TObject);
var
        balance : Double;
begin
        {**********************************************************************}
        { ��Ʈ���� �ܿ�����Ʈ�� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetPartnerBalance
        {**********************************************************************}
        
        try
                balance := bizInfoCheckService.GetPartnerBalance(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('�ܿ�����Ʈ : ' + FloatToStr(balance));
        end;

end;

procedure TfrmExample.btnCheckIDClick(Sender: TObject);
var
        response : TResponse;
begin
        {**********************************************************************}
        { ����ϰ��� �ϴ� ���̵��� �ߺ����θ� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#CheckID
        {**********************************************************************}
        
        try
                response := bizInfoCheckService.CheckID(txtUserID.Text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('�����ڵ� : ' + IntToStr(response.code) + #10#13 + '����޽��� : '+ response.Message);
        end;
end;

procedure TfrmExample.btnRegistContactClick(Sender: TObject);
var
        response : TResponse;
        joinInfo : TJoinContact;
begin
        {**********************************************************************}
        { ����ȸ�� ����ڹ�ȣ�� �����(�˺� �α��� ����)�� �߰��մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#RegistContact
        {**********************************************************************}

        // [�ʼ�] ����� ���̵� (6�� �̻� 50�� �̸�)
        joinInfo.id := 'testkorea';

        // ��й�ȣ (8�� �̻� 20�� �̸�) ����, ���� ,Ư������ ����
        joinInfo.Password := 'asdf123!@';

        // [�ʼ�] ����ڸ�(�ѱ��̳� ���� 100�� �̳�)
        joinInfo.personName := '����ڼ���';

        // [�ʼ�] ����ó (�ִ� 20��)
        joinInfo.tel := '070-4304-2991';

        // [�ʼ�] �̸��� (�ִ� 100��)
        joinInfo.email := 'test@test.com';

        // ����� ����, 1-���α��� / 2-�б���� / 3-ȸ�����
        joinInfo.searchRole := '3';

        try
                response := bizInfoCheckService.RegistContact(txtCorpNum.text, joinInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
               ShowMessage('�����ڵ� : ' + IntToStr(response.code) + #10#13 + '����޽��� : '+ response.Message);
        end;

end;

procedure TfrmExample.btnListContactClick(Sender: TObject);
var
        InfoList : TContactInfoList;
        tmp : string;
        i : Integer;
begin
        {**********************************************************************}
        { ����ȸ�� ����ڹ�ȣ�� ��ϵ� �����(�˺� �α��� ����) ����� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#ListContact
        {**********************************************************************}

        try
                InfoList := bizInfoCheckService.ListContact(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;

        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
               tmp := 'id(���̵�) | email(�̸���) | hp(�޴���) | personName(����) | searchRole(����� ����) | ';
                tmp := tmp + 'tel(����ó) | fax(�ѽ�) | mgrYN(������ ����) | regDT(����Ͻ�) | state(����)' + #13;

                for i := 0 to Length(InfoList) -1 do
                begin
                    tmp := tmp + InfoList[i].id + ' | ';
                    tmp := tmp + InfoList[i].email + ' | ';
                    tmp := tmp + InfoList[i].personName + ' | ';
                    tmp := tmp + InfoList[i].searchRole + ' | ';
                    tmp := tmp + InfoList[i].tel + ' | ';
                    tmp := tmp + BoolToStr(InfoList[i].mgrYN) + ' | ';
                    tmp := tmp + InfoList[i].regDT + ' | ';
                    tmp := tmp + IntToStr(InfoList[i].state) + #13;
                end;
                ShowMessage(tmp);
        end;

end;

procedure TfrmExample.btnUpdateContactClick(Sender: TObject);
var
        contactInfo : TContactInfo;
        response : TResponse;
begin

        {**********************************************************************}
        { ����ȸ�� ����ڹ�ȣ�� ��ϵ� �����(�˺� �α��� ����) ������ �����մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#UpdateContact
        {**********************************************************************}

        contactInfo := TContactInfo.Create;

        // ����� ���̵�
        contactInfo.id := 'testkorea';

        // ����ڸ� (�ִ� 100��)
        contactInfo.personName := '�׽�Ʈ �����';

        // ����ó (�ִ� 20��)
        contactInfo.tel := '070-4304-2991';

        // �̸��� �ּ� (�ִ� 100��)
        contactInfo.email := 'test@test.com';

        // ����� ����, 1-���α��� / 2-�б���� / 3-ȸ�����
        contactInfo.searchRole := '3';

        try
                response := bizInfoCheckService.UpdateContact(txtCorpNum.text, contactInfo, txtUserID.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
               ShowMessage('�����ڵ� : ' + IntToStr(response.code) + #10#13 + '����޽��� : '+ response.Message);
        end;
end;

procedure TfrmExample.btnGetCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        tmp : string;
begin
        {**********************************************************************}
        { ����ȸ���� ȸ�������� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#GetCorpInfo
        {**********************************************************************}

        try
                corpInfo := bizInfoCheckService.GetCorpInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;

        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                tmp := 'CorpName (��ȣ) : ' + corpInfo.CorpName + #13;
                tmp := tmp + 'CeoName (��ǥ�ڼ���) : ' + corpInfo.CeoName + #13;
                tmp := tmp + 'BizType (����) : ' + corpInfo.BizType + #13;
                tmp := tmp + 'BizClass (����) : ' + corpInfo.BizClass + #13;
                tmp := tmp + 'Addr (�ּ�) : ' + corpInfo.Addr + #13;
                ShowMessage(tmp);
        end;

end;

procedure TfrmExample.btnUpdateCorpInfoClick(Sender: TObject);
var
        corpInfo : TCorpInfo;
        response : TResponse;
begin
        {**********************************************************************}
        { ����ȸ���� ȸ�������� �����մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#UpdateCorpInfo
        {**********************************************************************}

        corpInfo := TCorpInfo.Create;

        // ��ǥ�ڸ�, �ִ� 100��
        corpInfo.ceoname := '��ǥ�ڸ�';

        // ��ȣ, �ִ� 200��
        corpInfo.corpName := '��ȣ';

        // ����, �ִ� 100��
        corpInfo.bizType := '����';

        // ����, �ִ� 100��
        corpInfo.bizClass := '����';

        // �ּ�, �ִ� 300��
        corpInfo.addr := '����Ư���� ������ ������� 517';

        try
                response := bizInfoCheckService.UpdateCorpInfo(txtCorpNum.text, corpInfo);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('�����ڵ� : ' + IntToStr(response.code) + #10#13 + '����޽��� : '+ response.Message);
        end;
       
end;

procedure TfrmExample.btnGetChargeInfoClick(Sender: TObject);
var
        chargeInfo : TBizInfoCheckChargeInfo;
        tmp : String;
begin
        {**********************************************************************}
        { �˺� ���������ȸ API ���� ���������� Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetChargeInfo
        {**********************************************************************}

        try
                chargeInfo := bizInfoCheckService.GetChargeInfo(txtCorpNum.text);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;

        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage('�����ڵ� : ' + IntToStr(bizInfoCheckService.LastErrCode) + #10#13 +'����޽��� : '+ bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                tmp := 'unitCost (�ܰ�) : ' + chargeInfo.unitCost + #13;
                tmp := tmp + 'chargeMethod (��������) : ' + chargeInfo.chargeMethod + #13;
                tmp := tmp + 'rateSystem (��������) : ' + chargeInfo.rateSystem + #13;
                ShowMessage(tmp);
        end;


end;

procedure TfrmExample.btnGetPartnerURL_CHRGClick(Sender: TObject);
var
  resultURL : String;
begin
        {**********************************************************************}
        { ��Ʈ�� ����Ʈ ������ ���� �������� �˾� URL�� ��ȯ�մϴ�.
        { - ��ȯ�Ǵ� URL�� ���� ��å�� 30�� ���� ��ȿ�ϸ�, �ð��� �ʰ��� �Ŀ��� �ش� URL�� ���� ������ ������ �Ұ��մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetPartnerURL
        {**********************************************************************}
        
        try
                resultURL := bizInfoCheckService.getPartnerURL(txtCorpNum.Text, 'CHRG');
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :  ' + #13 + resultURL);
        end;
end;

procedure TfrmExample.btnGetPaymentURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { ����ȸ�� ����Ʈ �������� Ȯ���� ���� �������� �˾� URL�� ��ȯ�մϴ�.
        { - ��ȯ�Ǵ� URL�� ���� ��å�� 30�� ���� ��ȿ�ϸ�, �ð��� �ʰ��� �Ŀ��� �ش� URL�� ���� ������ ������ �Ұ��մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetPaymentURL
        {**********************************************************************}
        
        try
                resultURL := bizInfoCheckService.getPaymentURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :  ' + #13 + resultURL);
        end;
end;

procedure TfrmExample.btnGetUseHistoryURLClick(Sender: TObject);
var
        resultURL : String;
begin
        {**********************************************************************}
        { ����ȸ�� ����Ʈ ��볻�� Ȯ���� ���� �������� �˾� URL�� ��ȯ�մϴ�.
        { - ��ȯ�Ǵ� URL�� ���� ��å�� 30�� ���� ��ȿ�ϸ�, �ð��� �ʰ��� �Ŀ��� �ش� URL�� ���� ������ ������ �Ұ��մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/point#GetUseHistoryURL
        {**********************************************************************}

        try
                resultURL := bizInfoCheckService.getUseHistoryURL(txtCorpNum.Text, txtUserID.Text);
                txtURL.Text := resultURL;
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage(IntToStr(bizInfoCheckService.LastErrCode) + ' | ' +  bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                ShowMessage('URL :  ' + #13 + resultURL);
        end;
end;

procedure TfrmExample.btnGetContactInfoClick(Sender: TObject);
var
        contactInfo : TContactInfo;
        contactID : string;
        tmp : string;
begin
        {**********************************************************************}
        { ����ȸ�� ����ڹ�ȣ�� ��ϵ� �����(�˺� �α��� ����) ������ Ȯ���մϴ�.
        { - https://developers.popbill.com/reference/bizinfocheck/delphi/api/member#GetContactInfo
        {**********************************************************************}

        contactID := 'testkorea';
        
        try
                contactInfo := bizInfoCheckService.getContactInfo(txtCorpNum.Text, contactID);
        except
                on le : EPopbillException do begin
                        ShowMessage('�����ڵ� : ' + IntToStr(le.code) + #10#13 +'����޽��� : '+ le.Message);
                        Exit;
                end;
        end;
        if bizInfoCheckService.LastErrCode <> 0 then
        begin
                ShowMessage('�����ڵ� : ' + IntToStr(bizInfoCheckService.LastErrCode) + #10#13 +'����޽��� : '+ bizInfoCheckService.LastErrMessage);
        end
        else
        begin
                tmp := 'id (���̵�) : ' + contactInfo.id + #13;
                tmp := tmp + 'personName (����� ����) : ' + contactInfo.personName + #13;
                tmp := tmp + 'tel (����� ����ó(��ȭ��ȣ)) : ' + contactInfo.tel + #13;
                tmp := tmp + 'email (����� �̸���) : ' + contactInfo.email + #13;
                tmp := tmp + 'regDT (��� �Ͻ�) : ' + contactInfo.regDT + #13;
                tmp := tmp + 'searchRole (����� ����) : ' + contactInfo.searchRole + #13;
                tmp := tmp + 'mgrYN (������ ����) : ' + booltostr(contactInfo.mgrYN) + #13;
                tmp := tmp + 'state (��������) : ' + inttostr(contactInfo.state) + #13;
                ShowMessage(tmp);
        end
end;



end.
