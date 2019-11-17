% Fourier transform function using matlab
% This program include 1D,2D FFT analysis
% The calculation method include fft function and power_gui
% fft 使用列向量进行计算，fft2按先列后行的方式进行运算
function [Fourier]=FFT_fun(data,time,space,f0,fmax,type,method)
switch type
    case '1D'
        switch method
            case 'fun'
                Fourier.xdata=time;
                Fourier.ydata=data;
                N=length(Fourier.xdata);% 采样点数
                Fs=1/(Fourier.xdata(2)-Fourier.xdata(1));% 采样频率:f0*N
                Fourier.ComplexData=fft(Fourier.ydata,[],1);
                Fourier.ComplexData=fftshift(Fourier.ComplexData,1);% 中心化
                Fourier.Amplitude=abs(Fourier.ComplexData)/N;% 幅值转化，由于采样离散化造成
                Fourier.Phase=angle(Fourier.ComplexData)*180/pi;% 相位求解
                Fourier.Frequency=((1:N)-(N/2+1))'*Fs/N;% 频率转化
                Fourier.Order=round(Fourier.Frequency/Fourier.Frequency(N/2+1+1));% 阶次求解
                % ========= 双边谱转化为单边谱，即将负的频率全部转化为正的频率 ================
                Fourier.P.ComplexData=Fourier.ComplexData(N/2+1:end,:);
                Fourier.P.Amplitude=2*Fourier.Amplitude(N/2+1:end,:);
                Fourier.P.Amplitude(1,:)=Fourier.P.Amplitude(1,:)/2;% 直流分量幅值转化，直流分量幅值不变
                Fourier.P.Phase=Fourier.Phase(N/2+1:end,:);
                Fourier.P.Frequency=Fourier.Frequency(N/2+1:end,:);
                Fourier.P.Order=Fourier.Order(N/2+1:end,:);
            case 'gui'
                FFT_signal.time = [0:1e-6:(length(data)-1)*1e-06]'; %由采样率和总时间长度决定
                FFT_signal.signals.values(:,1) =data(:,1); % 1 表示第一列
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
        %% 信号FFT分析
        TimeDomain.Time=time;
        TimeDomain.Space=space;
        N.Time=length(TimeDomain.Time);% 时间采样点数
        Fs.Time=f0*N.Time;% 时间采样频率
        N.Space=length(TimeDomain.Space);
        Fs.Space=1/360*N.Space;% 1/(TimeDomain.Space(2)-TimeDomain.Space(1)) 空间采样频率
        Fourier.ComplexData=fft2(data,N.Space,N.Time);
        Fourier.ComplexData=fftshift(Fourier.ComplexData);%中心化
        Fourier.ComplexData=Fourier.ComplexData/(N.Time*N.Space);
        Fourier.Amplitude=abs(Fourier.ComplexData);% 幅值转化，由于采样离散化造成
        Fourier.Phase=angle(Fourier.ComplexData)*180/pi;% 相位求解
        Fourier.Frequency=((1:N.Time)-(N.Time/2+1))*Fs.Time/N.Time;% 时间频率转化
        Fourier.TimeOrder=round(Fourier.Frequency/Fourier.Frequency(N.Time/2+1+1));% 时间阶次求解
        Fourier.SpaceFreq=((1:N.Space)-(N.Space/2+1))*Fs.Space/N.Space;% 空间频率转化
        Fourier.SpaceOrder=-round(Fourier.SpaceFreq/Fourier.SpaceFreq(N.Space/2+1+1));% 空间阶次求解
        % ========= 双边谱转化为单边谱，即将负的频率全部转化为正的频率 ================
        Fourier.P.ComplexData=Fourier.ComplexData(:,N.Time/2+1:end);
        Fourier.P.Amplitude=2*Fourier.Amplitude(:,N.Time/2+1:end);
        Fourier.P.Amplitude(:,1)=Fourier.P.Amplitude(:,1)/2;% 直流分量幅值转化，直流分量幅值不变
        Fourier.P.Phase=Fourier.Phase(:,N.Time/2+1:end);
        Fourier.P.Frequency=Fourier.Frequency(:,N.Time/2+1:end);
        Fourier.P.TimeOrder=Fourier.TimeOrder(:,N.Time/2+1:end);
        Fourier.P.SpaceFreq=Fourier.SpaceFreq;
        Fourier.P.SpaceOrder=Fourier.SpaceOrder;
end
end