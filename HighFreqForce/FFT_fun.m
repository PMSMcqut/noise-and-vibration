% Fourier transform function using matlab
% This program include 1D,2D FFT analysis
% The calculation method include fft function and power_gui
% fft ʹ�����������м��㣬fft2�����к��еķ�ʽ��������
function [Fourier]=FFT_fun(data,time,space,f0,fmax,type,method)
switch type
    case '1D'
        switch method
            case 'fun'
                Fourier.xdata=time;
                Fourier.ydata=data;
                N=length(Fourier.xdata);% ��������
                Fs=1/(Fourier.xdata(2)-Fourier.xdata(1));% ����Ƶ��:f0*N
                Fourier.ComplexData=fft(Fourier.ydata,[],1);
                Fourier.ComplexData=fftshift(Fourier.ComplexData,1);% ���Ļ�
                Fourier.Amplitude=abs(Fourier.ComplexData)/N;% ��ֵת�������ڲ�����ɢ�����
                Fourier.Phase=angle(Fourier.ComplexData)*180/pi;% ��λ���
                Fourier.Frequency=((1:N)-(N/2+1))'*Fs/N;% Ƶ��ת��
                Fourier.Order=round(Fourier.Frequency/Fourier.Frequency(N/2+1+1));% �״����
                % ========= ˫����ת��Ϊ�����ף���������Ƶ��ȫ��ת��Ϊ����Ƶ�� ================
                Fourier.P.ComplexData=Fourier.ComplexData(N/2+1:end,:);
                Fourier.P.Amplitude=2*Fourier.Amplitude(N/2+1:end,:);
                Fourier.P.Amplitude(1,:)=Fourier.P.Amplitude(1,:)/2;% ֱ��������ֵת����ֱ��������ֵ����
                Fourier.P.Phase=Fourier.Phase(N/2+1:end,:);
                Fourier.P.Frequency=Fourier.Frequency(N/2+1:end,:);
                Fourier.P.Order=Fourier.Order(N/2+1:end,:);
            case 'gui'
                FFT_signal.time = [0:1e-6:(length(data)-1)*1e-06]'; %�ɲ����ʺ���ʱ�䳤�Ⱦ���
                FFT_signal.signals.values(:,1) =data(:,1); % 1 ��ʾ��һ��
                FFT_signal.signals.dimensions=1;
                FFT_signal.signals.label='';
                FFT_signal.signals.title='';
                FFT_signal.signals.plotStyle=[1,1];
                FFT_signal.blockName='';
                FFTDATA=power_fftscope(FFT_signal);
                FFTDATA.fundamental=f0;
                FFTDATA.startTime=3;
                FFTDATA.cycles=1;
                FFTDATA.maxFrequency=fmax;
                Fourier=power_fftscope(FFTDATA);
        end
    case '2D'
        %% �ź�FFT����
        TimeDomain.Time=time;
        TimeDomain.Space=space;
        N.Time=length(TimeDomain.Time);% ʱ���������
        Fs.Time=f0*N.Time;% ʱ�����Ƶ��
        N.Space=length(TimeDomain.Space);
        Fs.Space=1/360*N.Space;% 1/(TimeDomain.Space(2)-TimeDomain.Space(1)) �ռ����Ƶ��
        Fourier.ComplexData=fft2(data,N.Space,N.Time);
        Fourier.ComplexData=fftshift(Fourier.ComplexData);%���Ļ�
        Fourier.ComplexData=Fourier.ComplexData/(N.Time*N.Space);
        Fourier.Amplitude=abs(Fourier.ComplexData);% ��ֵת�������ڲ�����ɢ�����
        Fourier.Phase=angle(Fourier.ComplexData)*180/pi;% ��λ���
        Fourier.Frequency=((1:N.Time)-(N.Time/2+1))*Fs.Time/N.Time;% ʱ��Ƶ��ת��
        Fourier.TimeOrder=round(Fourier.Frequency/Fourier.Frequency(N.Time/2+1+1));% ʱ��״����
        Fourier.SpaceFreq=((1:N.Space)-(N.Space/2+1))*Fs.Space/N.Space;% �ռ�Ƶ��ת��
        Fourier.SpaceOrder=-round(Fourier.SpaceFreq/Fourier.SpaceFreq(N.Space/2+1+1));% �ռ�״����
        % ========= ˫����ת��Ϊ�����ף���������Ƶ��ȫ��ת��Ϊ����Ƶ�� ================
        Fourier.P.ComplexData=Fourier.ComplexData(:,N.Time/2+1:end);
        Fourier.P.Amplitude=2*Fourier.Amplitude(:,N.Time/2+1:end);
        Fourier.P.Amplitude(:,1)=Fourier.P.Amplitude(:,1)/2;% ֱ��������ֵת����ֱ��������ֵ����
        Fourier.P.Phase=Fourier.Phase(:,N.Time/2+1:end);
        Fourier.P.Frequency=Fourier.Frequency(:,N.Time/2+1:end);
        Fourier.P.TimeOrder=Fourier.TimeOrder(:,N.Time/2+1:end);
        Fourier.P.SpaceFreq=Fourier.SpaceFreq;
        Fourier.P.SpaceOrder=Fourier.SpaceOrder;
end
end