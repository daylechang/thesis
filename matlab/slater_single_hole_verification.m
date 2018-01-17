clear; clc


%[0.06426610978520282, -0.00014416775884665278;
cfd_data = [0.06426610978520282, 0;
0.01234706612824018, 0.033328964613368275;
0.020639722925144748, 0.032726081258191334;
0.030300589308001013, 0.029370904325032757;
0.03995199360644611, 0.019672346002621237;
0.05008252345189351, 0.011179554390563555];



efd_data = [0.012059673783939639, 0.03431230564964155;
0.036603710755445454, 0.026207981542455107;
0.044666540641628574, 0.01732076575657504;
0.04942177224024738,  0.013153210701277056;
0.054141503427901666, 0.0090231261087112;
0.06044960025569479,  0.004426562696064985;
% 0.06465393794749408, -0.00014416775884665278;
0.06465393794749408, 0;
0.04269634998138862,  0.01948885976408912;
0.04040359308970683,  0.022424639580602892;
0.038616588519754635, 0.0244167758846658;
0.03319403216170311,  0.029134993446920047;
0.028692895147592882, 0.031572739187418083;
0.025352740250925116, 0.032332896461336844];

mach = 2.46;
gamma = 1.4;
factor = (1+(gamma-1)*mach^2/2)^(gamma/(gamma-1));

plen_ratio_unscaled = 0:0.0025:0.07;
plen_ratio_scaled = plen_ratio_unscaled*factor;
slater_model_scaled = -0.59361420*plen_ratio_scaled.^2 + 0.03069346*plen_ratio_scaled + 0.59799735;
slater_model_unscaled = slater_model_scaled/factor;

slater_model_mod = -0.57*plen_ratio_scaled.^2 + 0.59799735;

% unscaled -> Q_sonic
% figure(1); clf; hold on
% plot(plen_ratio_unscaled,slater_model_unscaled,'k')
% scatter(efd_data(:,1),efd_data(:,2),'square','filled')
% scatter(cfd_data(:,1),cfd_data(:,2),'^','filled')

% scaled -> Q_sonic-B
figure(1); clf; hold on
plot(plen_ratio_scaled,slater_model_scaled,'k')
%plot(plen_ratio_scaled,slater_model_mod)
scatter(efd_data(:,1)*factor,efd_data(:,2)*factor,'square','filled')
scatter(cfd_data(:,1)*factor,cfd_data(:,2)*factor,'^','filled')

grid on
lgd = legend('Slater Model','Data','CFD','Location','Best');
lgd.Box = 'off';
xlim([0,1.2])
ylim([0,0.6])
ylabel('Surface Sonic Flow Coefficient')
xlabel('Plenum Static Pressure Ratio')

x0=10;
y0=10;
width=300;
height=250*3/4;
set(gcf,'units','points','position',[x0,y0,width,height])

% expand axis to fill figure
fig = gcf;
ax = findobj(fig,'type','axes');
for axn = 1:length(ax)
    outerpos = ax(axn).OuterPosition;
    ti = ax(axn).TightInset;
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax(axn).Position = [left bottom ax_width ax_height];
end

% save as
raw_name = fullfile('..','figures','slater_cfd_plot');
format = 'both';

set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')

switch format
    case 'png'
        print([raw_name, '.png'],'-dpng')
    case 'eps'
        print([raw_name, '.eps'],'-depsc')
    case 'both'
        print([raw_name, '.png'],'-dpng')
        print([raw_name, '.eps'],'-depsc')
    otherwise
        disp(['unrecognized format: ',format])
end

